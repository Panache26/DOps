function sum(a, b) {
    return a + b;
}
module.exports = sum;
if (require.main === module) {
    console.log('DevOps! 1 + 5 = ', sum(1, 5));
}