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
            data: [107, 31, 635, 203, 2, 25, 245, 345, 135, 25, 34, 25]
        }]
    });
}

function drawBar() {
    d3.json("assets/checkin.json", function(data) {
        var width = 600, height = 100;
        var margin = {top: 10, right: 0, bottom: 20, left: 0};
        var svg = d3.select("#demo").append("svg")
            .attr("width", width)
            .attr("height", height)
              .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        var color = ["#EBD3E8", "#E2C2DE", "#DABED5", "#D2A2CC", "#CA8EC2", "#C07AB8", "#B766AD", "#AE57A4", "#9F4D95", "#8F4586", "#7E3D76", "#6C3365"];

        var range = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
        svg.selectAll("rect")
            .data(color)
            .enter()
            .append("rect")
            .attr("width", (width-margin.left-margin.right)/12)
            .attr("height", 50)
            .attr("x", function(i, d) {console.log(i);return d*(width-margin.left-margin.right)/12;})
            .attr("fill", function(i, d) {console.log(i); return i;});

        var xScale = d3.scale.ordinal().domain(["0", "2", "4", "6", "8", "10", "12", "14", "16", "18", "20", "22", "24"]).rangePoints([0, width]);

        var xAxis = d3.svg.axis()
            .scale(xScale)
            .orient("bottom");
        svg.append("g")
            .attr("class", "axis")
            .attr("transform", "translate(" + 0 + "," + 60 + ")")
            .call(xAxis);
    });


}
