export default time => {
    var times = new Date(time);
    var y = times.getFullYear(); //年
    const m = (times.getMonth() + 1 + '').padStart(2, '0')
    const d = (times.getDate() + '').padStart(2, '0')
    return y + '-' + m + '-' + d;
};