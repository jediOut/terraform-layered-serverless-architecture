import { handler } from "./dist/lambda.js";

const event = {
    message: "test local"
}

handler(event).then((res => {
    console.log("Response: ", res);
})).catch((err) => {
    console.error(err);
});