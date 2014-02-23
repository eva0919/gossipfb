function drawChart() {
    $('#chart').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: '朋友出沒時間分布圖'
        },
        subtitle: {
            text: '瞧瞧他在哪？'
        },
        xAxis: {
            categories: ['0-2', '2-4', '4-6', '6-8', '8-10', '10-12', '12-14', '14-16', '16-18', '18-20', '20-22', '22-24'],
            title: {
                text: null
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: '出現頻率',
                align: 'high'
            },
            labels: {
                overflow: 'justify'
            }
        },
        tooltip: {
            valueSuffix: ' 次'
        },
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true
                }
            }
        },
        credits: {
            enabled: false
        },
        series: [{
            name: 'Your Friend',
            data: [220, 104, 74, 48, 106, 141, 170, 161, 195, 173, 206, 296]
        }]
    });
}

function drawBar(turn_data) {
    var width = 600, height = 100;
    var margin = {top: 10, right: 15, bottom: 20, left: 10};

    var svg = d3.select("#demo").append("svg")
        .attr("width", width)
        .attr("height", height)
          .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    var color = ["#EBD3E8", "#E2C2DE", "#DABED5", "#D2A2CC", "#CA8EC2", "#C07AB8", "#B766AD", "#AE57A4", "#9F4D95", "#8F4586", "#7E3D76", "#6C3365"];

    svg.selectAll("rect")
        .data(turn_data)
        .enter()
        .append("rect")
        .attr("width", (width-margin.left-margin.right)/12)
        .attr("height", 50)
        .attr("x", function(i, d) {console.log("pos" + d);return d*(width-margin.right)/12;})
        .transition()
        .duration(500) // this is 1s
        .delay(100)
        .attr("fill", function(i, d) {console.log(color);console.log("fill" + i); if (i>12) return 11; else return color[i];});

    var xScale = d3.scale.ordinal().domain(["0", "2", "4", "6", "8", "10", "12", "14", "16", "18", "20", "22", "24"]).rangePoints([0, width-margin.right]);

    var xAxis = d3.svg.axis()
        .scale(xScale)
        .orient("bottom");
    svg.append("g")
        .attr("class", "axis")
        .attr("transform", "translate(" + 0 + "," + 60 + ")")
        .call(xAxis);
}

function redrawBar(turn_data) {
    d3.select("#demo svg").remove();
    drawBar(turn_data);
}
