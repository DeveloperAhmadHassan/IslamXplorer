import React, { useRef, useState } from "react";
import { GraphCanvas, useSelection } from "reagraph";
import "./styles.scss";
import { Alert, Button, Checkbox, FormControlLabel, FormGroup, Snackbar } from "@mui/material";

import BasicMenu from "./BasicMenu";
import generateRandomGraph from "./generateRandomGraph";
import { SideMenu } from "./SideMenu";

export const Dummy = () => {
  const [complexNodes, setComplexNodes] = useState([
    {
      id: 'n-1',
      label: '1',
      type:'node'
    },
    {
      id: 'n-2',
      label: '2',
      type:'node'
    },
    {
      id: 'n-3',
      label: '3',
      type:'node'
    },
    {
      id: 'n-4',
      label: '4',
      type:'node'
    },
    {
      id: 'n-5',
      label: '5',
      type:'node'
    }
  ]);

  const [complexEdges, setComplexEdges] = useState([
    {
      id: '1->2',
      source: 'n-1',
      target: 'n-2',
      label: '0',
      ilabel: 'Edge 1-2',
      weight: '0',
      type:'edge'
    },
    {
      id: '1->3',
      source: 'n-1',
      target: 'n-3',
      label: '0',
      ilabel: 'Edge 1-3',
      weight: '0',
      type:'edge'
    },
    {
      id: '3->4',
      source: 'n-3',
      target: 'n-4',
      label: '0',
      ilabel: 'Edge 3-4',
      weight: '0',
      type:'edge'
    },
    {
      id: '2->5',
      source: 'n-2',
      target: 'n-5',
      label: '0',
      ilabel: 'Edge 2-5',
      weight: '0',
      type:'edge'
    }
  ]);

  const [snackbarData, setSnackbarData]=useState([{
    severity:'success',
    message:'dummy message'
  }]);

  const [open, setOpen] = useState(false);
  const [loading, setLoading] = useState(false);
  const [curvedEdges, setCurvedEdges] = useState("linear"); 
  const [directed, setDirected] = useState("end"); 

  const graphRef = useRef();

  const addNode = (event) => {    
    const newNode = {
      id: `n-${complexNodes.length + 1}`,
      label: `${complexNodes.length + 1}`,
      type:'node' 
    };

    const updatedNodes = [...complexNodes, newNode];
    setComplexNodes(updatedNodes); 
  };

  const checkSelections = () =>{
    if(selections.length === 2){
      const weight = (Math.floor(Math.random() * (100 - 1 + 1)) + 1).toString();
      const obj = {
        id:`${selections[0].substring(2)}->${selections[1].substring(2)}`,
        source:selections[0],
        target:selections[1],
        label:`${weight}`,
        ilabel:`${selections[0].substring(2)}-${selections[1].substring(2)}`,
        weight:`${weight}`,
        type:'edge'
      }
  
      const idExists = complexEdges.some(edge => edge.id === obj.id);
      // const reverseIdExists = complexEdges.some(edge => edge.id.split('->').reverse().join('->') === obj.id);
  
      if(idExists){
        setSnackbarData({
          severity:'error',
          message:'This Edge already exists!'
        })
        setOpen(true);
      }
  
      // if(reverseIdExists){
      //   setSnackbarData({
      //     severity:'error',
      //     message:`There is already an edge between ${selections[0]} and ${selections[1]}`
      //   })
      //   setOpen(true);
      // }
  
      if (!idExists) {
        setComplexEdges(prevEdges => [...prevEdges, obj]);
        setSnackbarData({
          severity:'success',
          message:`Created a new Edge between ${selections[0]} and ${selections[1]}`
        })
        setOpen(true);
      }

      clearSelections();
    }
  };

  let {
    actives,
    selections,
    clearSelections,
    onNodeClick,
    onCanvasClick,
    onLasso,
    onLassoEnd,
  } = useSelection({
    ref: graphRef,
    nodes: complexNodes,
    edges: complexEdges,
    type: 'multi',
    focusOnSelect: true,
  });

  const deleteNodeByID = (idToDelete) => {
    // Filter out nodes with idToDelete
    const filteredNodes = complexNodes.filter(node => node.id !== idToDelete);
    // Filter out edges where source or target is equal to idToDelete
    const filteredEdges = complexEdges.filter(edge => edge.source !== idToDelete && edge.target !== idToDelete);
    // Update both complexNodes and complexEdges
    setComplexNodes(filteredNodes);
    setComplexEdges(filteredEdges);
  };
  const deleteNode = () => {
    if (complexNodes.length === 0) {
        return;
    }

    const idToDelete = complexNodes[complexNodes.length - 1].id;

    const filteredNodes = complexNodes.slice(0, -1);

    const filteredEdges = complexEdges.filter(edge => edge.source !== idToDelete && edge.target !== idToDelete);

    setComplexNodes(filteredNodes);
    setComplexEdges(filteredEdges);
  };
  const deleteEdge = (idToDelete) => {
    setComplexEdges(complexEdges.filter(node => node.id !== idToDelete));
  };
  const clearCanvas = () => {
    setComplexNodes([]);
    setComplexEdges([]);
  };
  const exportGraph = () =>{
    const data = graphRef.current.exportCanvas();
    const link = document.createElement('a');
    link.setAttribute('href', data);
    link.setAttribute('target', '_blank');
    link.setAttribute('download', 'graph.png');
    link.click();
  };
  const handleClose = (event, reason) => {
    if (reason === 'clickaway') {
      return;
    }

    setOpen(false);
  };
  const changeWeight = (e, id)=>{
    const updatedEdges = complexEdges.map(edge => {
      if (edge.id === id) {
        return { ...edge, label: e.target.value, weight: e.target.value.toString() };
      }
      return edge;
    });
    setComplexEdges(updatedEdges);
  };

  const centerGraph = () =>{
    graphRef.current?.centerGraph();
  }
  const sendData = async () => {
    // setLoading(true);
    const startNode = window.prompt("Please enter Start Node:");

    if (startNode === null || startNode.trim() === "") {
      return;
    }

    let newNodes = complexNodes.map(node => {
      const { id } = node;
      const modifiedId = id.replace('n-', '');
      return { id: modifiedId };
    });

    let newEdges = complexEdges.map(edge => {
      let { source, target, weight } = edge;
      source = source.replace('n-', '');
      target = target.replace('n-', '');

      return { source: source, target: target, weight: weight };
    });

    let graph = newNodes.reduce((key, node) => {
      key[node.id] = {};
      return key;
    }, {});

    newEdges.forEach(edge => {
      const sourceNode = graph[edge.source];
      if (sourceNode) {
        sourceNode[edge.target] = parseInt(edge.weight);
      }
    });

    if (!(startNode in graph)) {
      setSnackbarData({
          severity:'error',
          message:`Invalid Start Node!`
        })
        setOpen(true);
        return;
    }

    const data = {
      "startNode":parseInt(startNode),
      "graph":graph
    }

    console.log(data);

    await fetch("http://192.168.56.1:48275/solve-graph", {
                  method: "POST",
                  headers: {
                    "Content-Type": "application/json"
                  },
                  body: JSON.stringify(data)
                });
  };

  const handleCurveEdges = (event)=>{
    if(event.target.checked){
      setCurvedEdges("curved");
      return
    }
    setCurvedEdges("linear");
  };
  const handleDirectedEdges = (event)=>{
    if(event.target.checked){
      setDirected("none");
      return
    }
    setDirected("end");
  };

  const randomGraph = () =>{
    clearCanvas();
    const { nodes, edges } = generateRandomGraph();
    setComplexNodes(nodes);
    setComplexEdges(edges);
  }

  return (
    <div>
      <SideMenu addNode={addNode} deleteNode={deleteNode} clearCanvas={clearCanvas} exportGraph={exportGraph} sendData={sendData} handleCurveEdges={handleCurveEdges} handleDirectedEdges={handleDirectedEdges} centerGraph={centerGraph} loading={loading} directed={directed}/>
      
      <div style={{ width: "50px", height: "50px" }} id="graph">
      <GraphCanvas
        id="container"
        ref={graphRef}
        nodes={complexNodes}
        draggable
        edges={complexEdges}
        selections={selections}
        actives={actives}
        onNodeClick={onNodeClick}
        onCanvasClick={onCanvasClick}
        lassoType="node"
        onLasso={onLasso}
        onLassoEnd={onLassoEnd}
        edgeLabelPosition="inline" 
        labelType="all"
        onNodeDoubleClick={node => alert(node.label)}
        edgeArrowPosition={directed} 
        edgeInterpolation={curvedEdges}
        animated={true}
        contextMenu={({
            data,
            onClose,
          }) => <BasicMenu data={data} onClose={onClose} changeWeight={changeWeight} deleteEdge={deleteEdge} deleteNodeByID={deleteNodeByID} />}
      />
      </div>
      {checkSelections()}
      <Snackbar open={open} autoHideDuration={3000} onClose={handleClose}>
        <Alert
          onClose={handleClose}
          severity={snackbarData.severity}
          variant="filled"
          sx={{ width: '100%' }}
        >
          {snackbarData.message}
        </Alert>
      </Snackbar>
    </div>
  );
}
