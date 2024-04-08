import React from 'react'
import { useAuth } from '../../../../hooks/useAuth';

function Finish(props){
    const {user} = useAuth();

    const handleSubmit = async(e)=>{
        var a = window.confirm("Confirm your Ontology")
        e.preventDefault()
        if(a){
            let { data, dataContent, topicContent, ...other } = props.formData;
            let completedFormData = {
                "dataType": data,
                "dataID": dataContent.data,
                "topic": topicContent.type,
                "concept":topicContent.concept,
                "uid": user.uid
            };

            try {
                const response = await fetch("http://192.168.56.1:48275/ontologies", {
                  method: "POST",
                  headers: {
                    "Content-Type": "application/json"
                  },
                  body: JSON.stringify(completedFormData)
                });

                props.nextStep()
            } catch (error) {
                console.error("Error:", error);
            }
        }
    }

    const dataObj = {};
    const topicObj ={};

    function renderDataTypeContent(){
        switch(props.formData.dataContent.type){
            case 'quran': {
                dataObj['Surah'] = props.formData.dataContent.chapterName
                dataObj['Verse'] = props.formData.dataContent.data
                return (
                    <>
                        <div className="info">
                            <h5 className="plan-type">{`Data Source: Quran`}</h5>
                            <a href="#" onClick={props.secondStep}>change</a>
                        </div>
                    </>
                );
            }
            
            case 'hadith': {
                dataObj['Hadith Book'] = props.formData.dataContent.chapterName
                dataObj['Hadith'] = props.formData.dataContent.data
                return (
                    <>
                        <div className="info">
                            <h5 className="plan-type">{`Data Source: Hadith`}</h5>
                            <a href="#" onClick={props.secondStep}>change</a>
                        </div>
                    </>
                );
            }
            default: return '$9/mo'
        }
    }

    function renderDataContent() {
        return(
            <div>
            {
                Object.keys(dataObj).map(key => (
                
                    <div>
                        <span className='type'>{key}</span>
                        <span className='value'>{dataObj[key]}</span>
                    </div>
                ))
            }
            </div>
        )
    }

    function renderTopicContent() {
        console.log(props.formData.topicContent);
        return(
            <div>
            {
                Object.keys(props.formData.topicContent).map(key => (
                
                    <div>
                        <span className='type'>{key}</span>
                        <span className='value'>{props.formData.topicContent[key]}</span>
                    </div>
                ))
            }
            </div>
        )
    }

    function renderOntologyContent() {
        return(<>
            <div className="ontology-summary">
                <div className="label">Ontology Summary</div>
                <div>
                    <span className='value'>The </span>
                    <span className="ontology-keyword">{`concept`}</span>
                    <span className='value'>of </span>
                    <span className="ontology-keyword">{`topic`}</span>
                    {props.formData.dataContent.type == 'quran' ? <span className='value'>is mentioned in </span> : <span className='value'>is explanined by </span>}
                    <span className="ontology-keyword">{`verse`}</span>
                </div>
            </div>
        </>)
    }
    return(
        
        <div className="content finish" id='no-box-shadow'>
            <h2>Finishing Up</h2>
            <p>Double-check everything looks OK before confirming.</p>
            <div className="summary">
                <div className="content-summary">
                    {renderDataTypeContent()}
                </div>
                <div className="data-summary">
                
                    {renderDataContent()}
                </div>
                <div className='data-summary'>
                    {renderTopicContent()}
                </div>
            </div>
            {renderOntologyContent()}
            <form onSubmit={handleSubmit}>
                <div className="buttons">
                    <input type="button" value="Go Back" onClick={props.prevStep} />
                    <input type="submit" value="Confirm" />
                </div>
            </form>
        </div>
    )
}

export default Finish