import { useState } from 'react';

// Constants for node and edge ranges
const MIN_NODES = 6;
const MAX_NODES = 100;
const MIN_EDGES = 5;
const MAX_EDGES = 99;

// Function to generate a random integer within a range
const getRandomInt = (min, max) => {
  return Math.floor(Math.random() * (max - min + 1)) + min;
};

// Function to generate random nodes
const generateRandomNodes = (numNodes) => {
  const nodes = [];
  for (let i = 1; i <= numNodes; i++) {
    nodes.push({
      id: `n-${i}`,
      label: `${i}`,
      type: 'node'
    });
  }
  return nodes;
};

// Function to generate random edges
const generateRandomEdges = (nodes, numEdges) => {
  const edges = [];
  const numNodes = nodes.length;
  const weight = (Math.floor(Math.random() * (100 - 1 + 1)) + 1).toString();
  for (let i = 0; i < numEdges; i++) {
    const sourceIndex = getRandomInt(0, numNodes - 1);
    let targetIndex = getRandomInt(0, numNodes - 1);
    while (targetIndex === sourceIndex) {
      targetIndex = getRandomInt(0, numNodes - 1);
    }
    edges.push({
      id: `${nodes[sourceIndex].id.substring(2)}->${nodes[targetIndex].id.substring(2)}`,
      source: nodes[sourceIndex].id,
      target: nodes[targetIndex].id,
      label:`${weight}`,
      ilabel: `${nodes[sourceIndex].id.substring(2)}-${nodes[targetIndex].id.substring(2)}`,
      weight:`${weight}`,
      type: 'edge'
    });
  }
  return edges;
};

// Function to generate a random graph
const generateRandomGraph = () => {
  // Generate random number of nodes and edges within the specified range
  const numNodes = getRandomInt(MIN_NODES, MAX_NODES);
  const numEdges = getRandomInt(MIN_EDGES, MAX_EDGES);

  // Generate nodes and edges based on the random number
  const nodes = generateRandomNodes(numNodes);
  const edges = generateRandomEdges(nodes, numEdges);
  
  return { nodes, edges };
};

// Usage:
// const [complexNodes, setComplexNodes] = useState([]);
// const [complexEdges, setComplexEdges] = useState([]);
// const { nodes, edges } = generateRandomGraph();
// setComplexNodes(nodes);
// setComplexEdges(edges);

export default generateRandomGraph;
