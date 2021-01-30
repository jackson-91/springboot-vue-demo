export default time => {
    var times = new Date(time);
    var y = times.getFullYear(); //年
    var m = times.getMonth() + 1; //月
    var d = times.getDate(); //日
    return y + '-' + m + '-' + d;
};