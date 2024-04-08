import React from 'react'

function SelectDataType(props){

    function handleSubmit(e){
        e.preventDefault()
        props.nextStep()
    }
    
    function changeDataType(event){
        let clicked = event.target.getAttribute('for')
        const toggleBtn = document.getElementsByClassName('select')[0]
        const options = document.getElementsByClassName('options')[0]

        toggleBtn.classList.remove('show-chapters','hide-chapters')
        toggleBtn.classList.add(clicked)
        if(clicked === "show-chapters"){
            options.classList.add('show-chapters')
        }else{
            options.classList.remove('show-chapters')
        }
    }


    function changePlanBtn(){
        const toggleBtn = document.getElementsByClassName('select')[0]
        const radio1 = document.querySelector('input[name="dataType"]:nth-of-type(1)');
        const radio2 = document.querySelector('input[name="dataType"]:nth-of-type(2)');
        const options = document.getElementsByClassName('options')[0]
    
        if (radio1.checked) {
            radio1.checked = false;
            radio2.checked = true;
            options.classList.add('show-chapters')
        } else{
            radio2.checked = false;
            radio1.checked = true;
            options.classList.remove('show-chapters')
        }

        if(toggleBtn.classList.contains('show-chapters')){
            toggleBtn.classList.remove('show-chapters')
            toggleBtn.classList.add('hide-chapters')
        }else{
            toggleBtn.classList.remove('hide-chapters')
            toggleBtn.classList.add('show-chapters')
        }
    }

    return(
        <div className="content select-data-type" id='no-box-shadow'>
                 <h2>Select your Data Source</h2>
                 <p>You have the option of Quran or Hadith</p>
                 <form onSubmit={handleSubmit}>
                     <div className="options">
                        <div className="option">
                            <input 
                                type="radio" 
                                required  
                                name="data" 
                                value="Verse"
                                id="quran" 
                                style={{visibility:"hidden", width:"0", height:"0"}}
                                onChange={props.handleOptionChange}
                                checked={props.data === "Verse"}
                            />
                            <label htmlFor="quran">
                                <div className="imgBox">
                                    <img src="/assets/images/icon-quran.svg" alt="" />
                                </div>
                                <div className="info">
                                     <h5>Quran</h5>
                                     <p>100 Verses</p>
                                     <span>15 Surahs</span>
                                </div>
                            </label>
                        </div>
                        <div className="option">
                            <input 
                                type="radio" 
                                name="data" 
                                id="hadith" 
                                value="hadith"
                                style={{visibility:"hidden", width:"0", height:"0"}}
                                onChange={props.handleOptionChange}
                                checked={props.data === "hadith"}
                            />
                            <label htmlFor="hadith">
                                <div className="imgBox">
                                    <img src="/assets/images/icon-hadith.svg" alt="" />
                                </div>
                                <div className="info">
                                     <h5>Hadith</h5>
                                     <p>75 Ahadith</p>
                                     <span>2 Books</span>
                                </div>
                            </label>
                        </div>
                        {/* <div className="option">
                            <input 
                                type="radio" 
                                name="data" 
                                id="pro" 
                                value="pro"
                                style={{visibility:"hidden", width:"0", height:"0"}}
                                onChange={props.handleOptionChange}
                                checked={props.data === "pro"}
                            />
                            <label htmlFor="pro">
                                <div className="imgBox">
                                    <img src="assets/images/icon-pro.svg" alt="" />
                                </div>
                                <div className="info">
                                     <h5>Pro</h5>
                                     <p>$15/mo</p>
                                     <span>2 months free</span>
                                </div>
                            </label>
                        </div> */}
                     </div>
                     <div className="dataType">
                         <input 
                            type="radio" 
                            name="dataType" 
                            id="hide-chapters" 
                            value="hide-chapters"
                            onChange={props.handleOptionChange}
                            checked={props.dataType === "hide-chapters"}
                         />
                         <label htmlFor="hide-chapters" onClick={changeDataType}>Hide Chapters</label>
                         <div className="select hide-chapters" onClick={changePlanBtn}>
                             <div className="button"></div>
                         </div>
                         <input 
                            type="radio" 
                            name="dataType" 
                            id="show-chapters" 
                            value="show-chapters"
                            onChange={props.handleOptionChange}
                            checked={props.dataType === "show-chapters"}
                         />
                         <label htmlFor="show-chapters" onClick={changeDataType}>Show Chapters</label>
                     </div>
                     <div className="buttons">
                         {/* <input type="button" value="Go Back" onClick={props.prevStep}/> */}
                         <input type="submit" value="Next Step" />
                     </div>
                 </form>
        </div>
    )
}

export default SelectDataType