const db = require("../data/db-config");

module.exports = {
    find,
    findById,
    findSteps,
    add,
    addStep,
    update,
    remove,
}

function find() {
    return db('schemes');
}

function findById(id) {
    return db('schemes').where({id}).first();
}

function findSteps(id) {
    return db("steps")
    .select("steps.id", "schemes.scheme_name", "steps.step_number", "steps.instructions")
    .join("schemes", "steps.scheme_id", "=", "schemes.id")
    .where("schemes.id", "=", id)
    .orderBy("steps.step_number");
}

function add(schemeData) {
    return db("schemes")
        .insert(schemeData, "id")
        .then(ids => {
            const [id] = ids;
            return findById(id);
        })
}

function addStep(stepData, schemeId) {
    const newStep = {...stepData, scheme_id: schemeId}

    return db("steps")
    .insert(newStep)
    .then(stepID => {
        return findSteps(schemeId);
    })
}

function update(changes, id) {
    return db("schemes")
    .update(changes)
    .where({id})
    .then(count => {
        return findById(id)
    })
}

function remove(id) {
    return db("schemes")
    .del()
    .where({id})
    .then(count => {
        return `${count} scheme(s) removed.`
    })
}