import request from "supertest";

import app from "./app";

describe("app", () => {
    describe("/", () => {
        it("should send hello world", async () => {
            expect.assertions(1);

            const response = await request(app).get("/");

            expect(response.text).toEqual("Hello World");
        });
    });
});
