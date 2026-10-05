// Libraries
const express = require('express');
const multer = require('multer');
const mysql = require('mysql2/promise');
const { check, validationResult } = require('express-validator');

// Setup
const app = express();
app.use(express.static('public'));

const upload = multer();
const port = 80;

let connection = null;

async function query(sql, params = []) {
    if (connection === null) {
        console.log('Connecting to database...');
        connection = await mysql.createConnection({
            host: "student-databases.cvode4s4cwrc.us-west-2.rds.amazonaws.com",
            user: "CAMRYNMARTINEZ",
            password: "IXL5snO6smtLywvpNN8sMxdpioCAzscrXER",
            database: "CAMRYNMARTINEZ"
        });
    }

    const [results] = await connection.execute(sql, params);
    return results;
}

app.get('/recipe-book/', upload.none(), async (request, response) => {
    try {

        let selectSql = `
            SELECT
                r.id,
                recipe_name,
                food_category,
                user_inputting
            FROM recipes_to_ingredients rti
            INNER JOIN recipes r ON r.id = rti.recipe_id
            INNER JOIN ingredients i ON i.id = rti.ingredient_id
        `;

        let whereStatements = [];
        let orderByStatements = [];
        let queryParameters = [];

        // Filters
        if (request.query.chefName) {
            whereStatements.push('r.user_inputting = ?');
            queryParameters.push(request.query.chefName);
        }

        if (request.query.recipeName) {
            whereStatements.push('r.recipe_name LIKE ?');
            queryParameters.push(`%${request.query.recipeName}%`);
        }

        if (request.query.category) {
            whereStatements.push('r.food_category LIKE ?');
            queryParameters.push(`%${request.query.category}%`);
        }

        if (request.query.sort) {
            if (request.query.sort === 'Z-A') {
                orderByStatements.push(`r.recipe_name DESC`);
            } else {
                orderByStatements.push(`r.recipe_name ASC`);
            }
        }

        // WHERE
        if (whereStatements.length > 0) {
            selectSql += ' WHERE ' + whereStatements.join(' AND ');
        }

        selectSql = selectSql + ` GROUP BY r.id`;
        // ORDER BY
        if (orderByStatements.length > 0) {
            selectSql += ' ORDER BY ' + orderByStatements.join(', ');
        }

        //Dynamically add LIMIT expressions to SELECT statements if needed
        if (typeof request.query.limit !== 'undefined' && request.query.limit >= 0 && request.query.limit <= 250) {
            selectSql = selectSql + ' LIMIT ' + request.query.limit;
        }

        const result = await query(selectSql, queryParameters);

        response.json({ data: result });

    } catch (error) {
        console.error(error);
        response.status(500).json({
            message: 'Something went wrong with the server.'
        });
    }
});

app.get(
    '/recipe-book/:id/',
    upload.none(),
    async (request, response) => {
        try {
            const result = await query(
                `SELECT
                    r.id,
                    r.recipe_name,
                    r.food_category,
                    r.user_inputting,
                    i.instructions
                FROM instructions i
                INNER JOIN recipes r ON r.id = i.recipe_id
                WHERE r.id = ?`,
                [request.params.id]
            );
            return response.json({ data: result[0] });
        } catch (error) {
            console.error(error);
            return response
                .status(500) //Error code
                .json({ message: 'Something went wrong with the server.' });
        }
    });

app.get(
    '/getData/:id/',
    async (request, response) => {
        let results = await query(
            `SELECT
                r.id,
                r.recipe_name,
                i.ingred,
                inst.instructions,
                rti.amount,
                rti.measurement
            FROM recipes_to_ingredients rti
            INNER JOIN recipes r ON r.id = rti.recipe_id
            INNER JOIN ingredients i ON i.id = rti.ingredient_id
            INNER JOIN instructions inst ON inst.recipe_id = r.id
            WHERE r.id = ?`,
            [request.params.id]
        );
        let recipe = {};
        recipe.id = results[0].id;
        recipe.recipe_name = results[0].recipe_name;
        recipe.instructions = results[0].instructions;
        //etc.
        recipe.ingredients = [];
        for (row of results) {
            let newIngredient = {}
            // TODO
            //
            newIngredient.ingred = row.ingred;
            newIngredient.measurement = row.measurement
            newIngredient.amount = row.amount;
            recipe.ingredients.push(newIngredient);
        }

        response.json(recipe);
    });

// -----------------------------
// POST route
// -----------------------------
app.post(
    '/recipe-book/',
    upload.none(),

    (request, response, next) => {
        try {
            request.body.ingredients = JSON.parse(
                request.body.ingredients || '[]'
            );
        } catch {
            return response.status(400).json({
                messages: ['Invalid ingredients format']
            });
        }

        next();
    },

    check('recipeName', 'Recipe name must be at least 3 characters')
        .trim()
        .isLength({ min: 3 }),
    check('category', 'Invalid category')
        .trim()
        .toLowerCase()
        .isIn(['breakfast', 'lunch/dinner', 'dessert']),
    check('chefName', 'Chef name must be inserted')
        .trim()
        .isLength({ min: 1 }),
    check('instructions', 'Instructions must be at least 10 characters')
        .trim()
        .isLength({ min: 10 }),
    check('ingredients', 'At least one ingredient is required')
        .isArray({ min: 1 }),
    check('ingredients.*.ingredient', 'Ingredient name is required')
        .trim()
        .notEmpty(),
    check('ingredients.*.amount', 'Enter a valid amount')
        .trim()
        .notEmpty(),
    check('ingredients.*.measurement', 'Measurement is required')
        .trim()
        .notEmpty(),

    // Final route
    async (request, response) => {

        const errors = validationResult(request);

        if (!errors.isEmpty()) {
            console.log(errors.array());

            return response.status(400).json({
                errors: errors.array().map(err => ({
                    field: err.path,
                    message: err.msg,
                    value: err.value
                }))
            });
        }

        try {
            const {
                recipeName,
                category,
                chefName,
                instructions
            } = request.body;

            const ingredients = request.body.ingredients;

            const result = await query(
                `INSERT INTO recipes
                (recipe_name, food_category, user_inputting)
                VALUES (?, ?, ?)`,
                [recipeName, category, chefName]
            );

            const recipeId = result.insertId;

            await query(
                `INSERT INTO instructions
                (instructions, recipe_id)
                VALUES (?, ?)`,
                [instructions, recipeId]
            );

            for (const item of ingredients) {

                let existing = await query(
                    `SELECT id
                     FROM ingredients
                     WHERE LOWER(TRIM(ingred)) = ?`,
                    [item.ingredient.trim().toLowerCase()]
                );

                let ingredientId;

                if (existing.length > 0) {
                    ingredientId = existing[0].id;
                } else {

                    const insertIng = await query(
                        `INSERT INTO ingredients (ingred)
                         VALUES (?)`,
                        [item.ingredient.trim()]
                    );

                    ingredientId = insertIng.insertId;
                }

                await query(
                    `INSERT INTO recipes_to_ingredients
                    (recipe_id, ingredient_id, amount, measurement)
                    VALUES (?, ?, ?, ?)`,
                    [
                        recipeId,
                        ingredientId,
                        item.amount,
                        item.measurement
                    ]
                );
            }

            response.json({
                message: 'Recipe added successfully!'
            });

        } catch (error) {
            console.error(error);

            response.status(500).json({
                message: 'Something went wrong with the server.'
            });
        }
    }
);
app.put(
    '/recipe-book/:id/',
    upload.none(),

    check('recipeName', 'Recipe name must be at least 3 characters')
        .trim()
        .isLength({ min: 3 }),
    check('category', 'Invalid category')
        .trim()
        .toLowerCase()
        .isIn(['breakfast', 'lunch/dinner', 'dessert']),
    check('chefName', 'Chef name must be inserted')
        .trim()
        .isLength({ min: 1 }),
    check('instructions', 'Instructions must be at least 10 characters')
        .trim()
        .isLength({ min: 10 }),
    async (request, response) => {
        //Validate request; If there any errors, send 400 response back
        const errors = validationResult(request)
        if (!errors.isEmpty()) {
            return response
                .status(400)
                .json({
                    message: 'Request fields or files are invalid.',
                    errors: errors.array(),
                });
        }

        try {
            const recipe = await query(
                `UPDATE recipes
                INNER JOIN instructions ON instructions.recipe_id = recipes.id
                SET recipe_name = ?,
                food_category = ?,
                user_inputting = ?,
                instructions = ?
                WHERE recipes.id = ?`,
                [
                    request.body.recipeName,
                    request.body.category,
                    request.body.chefName,
                    request.body.instructions,
                    request.params.id
                ]
            );
            response.json({ 'data': 'Survey response updated!' });
        } catch (error) {
            console.log(error);
            return response
                .status(500) //Error code
                .json({ message: 'Something went wrong with the server.' });
        }
    }
);

// -----------------------------
// Start server
// -----------------------------
app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});