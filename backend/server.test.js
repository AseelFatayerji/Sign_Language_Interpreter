const mongoose = require("mongoose")
const request = require("supertest")
const { default: axios } = require("axios");
require("dotenv").config();

describe("GET /user", () => {
    it("should return all users", async () => {
        return axios.get(":3001/user")
            .expect('Content-Type', /json/)
            .expect(200)
            .then((res) => {
                expect(res.statusCode).toBe(200);
            })
    });
});