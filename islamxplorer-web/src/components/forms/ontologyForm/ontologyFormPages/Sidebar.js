import React from 'react'

function Sidebar(props){
    
    const className1 = ['index', props.step === 1 ? 'active' : "" ].join(' ')
    const className2 = ['index', props.step === 2 ? 'active' : ""].join(' ')
    const className3 = ['index', props.step === 3 ? 'active' : ""].join(' ')
    const className4 = ['index', props.step === 4 || props.step === 5 ? 'active' : ""].join(' ')

    return(
         <div className="sidebar">
             <div className="step first">
                 <div className={className1}>1</div>
                 <div className="text">
                     <span>Step 1</span>
                     <p>Data  Source</p>
                 </div>
             </div>
             <div className="step second">
                 <div className={className2}>2</div>
                 <div className="text">
                     <span>Step 2</span>
                     <p>Select Data</p>
                 </div>
             </div>
             <div className="step third">
                 <div className={className3}>3</div>
                 <div className="text">
                     <span>Step 3</span>
                     <p>Select Concepts</p>
                 </div>
             </div>
             <div className="step fourth">
                 <div className={className4}>4</div>
                 <div className="text">
                     <span>Step 4</span>
                     <p>Summary</p>
                 </div>
             </div>
         </div>
    )
}

export default Sidebar