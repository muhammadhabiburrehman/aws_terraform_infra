exports.handler = async function (event) {
  console.log("Secret is:", process.env.MY_SECRET);
  return {
    statusCode: 200,
    body: "Hello from Lambda!",
  };
};
