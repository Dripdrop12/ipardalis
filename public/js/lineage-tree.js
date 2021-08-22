
// rest of vars
var x_browser = 20,
    y_browser = 25,
    root;
    
var margin = {top: 20, right: 120, bottom: 20, left: 120},
  width = 1200 - margin.right - margin.left,
  height = 1000 - margin.top - margin.bottom;

var i = 0;
var path;
var tree = d3.layout.tree()
  .size([height, width]); 

var diagonal = d3.svg.diagonal()
	.projection(function(d) { return [d.y, d.x]; });

var svg = d3.select("#vis").append("svg")
  .attr("width", width + margin.right + margin.left)
  .attr("height", height + margin.top + margin.bottom)
  .append("g")
  .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

d3.json(path, function(json) {

  root = json;
 
  update(root);
});


function update(root) {
  var nodes = tree.nodes(root).reverse(),
	  links = tree.links(nodes);  

  // Normalize for fixed-depth.
  nodes.forEach(function(d) { d.y = d.depth * 180; });

  // Declare the nodes…
  var node = svg.selectAll("g.node")
    .data(nodes, function(d) { return d.id || (d.id = ++i); });
  
  // Enter the nodes.
  var nodeEnter = node.enter().append("g")
    .attr("class", "node")
    .attr("transform", function(d) { 
    return "translate(" + d.y + "," + d.x + ")"; });

  nodeEnter.append("circle")
    .attr("r", function(d) { return d.value; })
    .style("stroke", "black")
    .style("fill", "black");
  
  // Declare the links…
  var link = svg.selectAll("path.link")
    .data(links, function(d) { return d.target.id; });

  // Enter the links.
  link.enter().insert("path", "g")
    .attr("class", "link")
    .style("stroke", "black")
    .attr("d", diagonal);
      
  // Append images
  var images = nodeEnter.append("svg:image")
        .attr("xlink:href",  function(d) { return d.img;})
        .attr("x", function(d) { return -75;})
        .attr("y", function(d) { return -75;})
        .attr("height", 150)
        .attr("width", 150);
  
  // make the image grow a little on mouse over and add the text details on click
  var setEvents = images
    // Append name text
    .on( 'click', function(d) {
      d3.select("h2").html(d.name); 
      d3.select("h3").html(d.company); 
      d3.select("#dam").html(d.dam);
      d3.select("#sire").html(d.sire);
      d3.select("h4").html ("Take me to " + "<a href='" + d.link + "' >"  + d.company + "'s web page ⇢"+ "</a>" ); 
    })
    
    .on( 'mouseenter', function() {
      
      // select element in current context
      d3.select( this )
        .transition()
        .attr("x", function(d) { return -175;})
        .attr("y", function(d) { return -175;})
        .attr("opacity", 0.9)
        .attr("height", 500)
        .attr("width", 500);
    })
    // set back
    .on( 'mouseleave', function() {
      d3.select( this )
        .transition()
        .attr("x", function(d) { return -25;})
        .attr("y", function(d) { return -25;})
        .attr("opacity", 1)
        .attr("height", 150)
        .attr("width", 150);
    });

  // Append name on roll over next to the node as well
  nodeEnter.append("text")
      .attr("class", "nodetext")
      .attr("x", -120)
      .attr("y", 100)
      .attr("fill", "white")
      .text(function(d) { return d.name + " - " + d.company; });
 
  // Exit any old nodes.
  node.exit().remove();
 
  // Re-select for update.
  link = vis.selectAll("path.link");
  node = vis.selectAll("g.node");
}

 
/**
 * Gives the coordinates of the border for keeping the nodes inside a frame
 * http://bl.ocks.org/mbostock/1129492
 */ 
function nodeTransform(d) {
  d.x =  Math.max(maxNodeSize, Math.min(w - (d.imgwidth/2 || 16), d.x));
    d.y =  Math.max(maxNodeSize, Math.min(h - (d.imgheight/2 || 16), d.y));
    return "translate(" + d.x + "," + d.y + ")";
   }
 
/**
 * Toggle children on click.
 */ 
function click(d) {
  if (d.children) {
    d._children = d.children;
    d.children = null;
  } else {
    d.children = d._children;
    d._children = null;
  }
 
  update();
}
 
 
/**
 * Returns a list of all nodes under the root.
 */ 
function flatten(root) {
  var nodes = []; 
  var i = 0;
 
  function recurse(node) {
    if (node.children) 
      node.children.forEach(recurse);
    if (!node.id) 
      node.id = ++i;
    nodes.push(node);
  }
 
  recurse(root);
  return nodes;
}