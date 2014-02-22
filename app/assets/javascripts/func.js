function drawChart() {
    d3.json("assets/checkin.json", function(data) {
        var width = 640, height = 100;
        var margin = {top: 5, right: 10, bottom: 20, left: 10};
        var svg = d3.select("#demo").append("svg")
            .attr("width", width)
            .attr("height", height)
              .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        var color = ["#4e3a6a", "#cc1075", "#e1dbfd", "#db579e", "#93b559", "#638e22", "#e1811d", "#0191d8", 
                     "#f7464a", "#8cc63e", "#f7464a", "#075792"];

        var range = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
        svg.selectAll("rect")
            .data(color)
            .enter()
            .append("rect")
            .attr("width", width/12)
            .attr("height", 50)
            .attr("x", function(i, d) {console.log(i);return d*width/12;})
            .attr("fill", function(i, d) {console.log(i); return i;});

        var xScale = d3.scale.ordinal().domain(["0-2", "2-4", "4-6", "6-8", "8-10", "10-12", "12-14", "14-16", "16-18", "18-20", "20-22", "22-24"]).rangePoints([margin.left, width-margin.right]);

        var xAxis = d3.svg.axis()
            .scale(xScale)
            .orient("bottom");
        svg.append("g")
            .attr("class", "axis")
            .attr("transform", "translate(" + 0 + "," + height + ")")
            .call(xAxis);
    });


}


$(document).ready(function() {
    drawChart();
});
