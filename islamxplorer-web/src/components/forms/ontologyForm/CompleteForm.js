import React from 'react'
import Sidebar from './ontologyFormPages/Sidebar.js'
import Personinfo from './ontologyFormPages/SelectTopic.js'
import SelectDataType from './ontologyFormPages/SelectDataType.js'
import Finish from './ontologyFormPages/Finish.js'
import Thanks from './ontologyFormPages/Thanks.js'

import "./styles.scss";
import SelectHadithData from './ontologyFormPages/SelectHadithData.js'
import SelectQuranData from './ontologyFormPages/SelectQuranData.js'
import SelectTopic from './ontologyFormPages/SelectTopic.js'

function OntologyForm(){

    const [formData, setFormData] = React.useState({
        step:1,
        data: 'Verse', 
        dataType: 'hide-chapters',
        dataContent: { dataType: '', chapterName: '', data: '', extra:[] },
        topicContent: { type: '', concept: '' }
    })

    const {step} = formData
    const {data, dataType} = formData
    const {dataContent} = formData
    const {topicContent} = formData

    function prevStep(){
        const {step} = formData
        setFormData((prevFormData) => ({ ...prevFormData, step: step - 1}))
    }

    function nextStep(){
        const {step} = formData
        setFormData((prevFormData) => ({ ...prevFormData, step: step + 1}))
    }

    function secondStep(){
        const {step} = formData
        setFormData((prevFormData) => ({ ...prevFormData, step: 2}))
    }

    function handleChange(e){
          setFormData((prevFormData) => ({
            ...prevFormData,
            [e.target.name] : e.target.value
        }))
          
    }

    function handleOptionChange(event){
        setFormData({
            step: 1,
            data: event.target.value,
            dataType: 'hide-chapters',
            dataContent: { dataType: '', chapterName: '', data: '', extra: [] },
            topicContent: { type: '', concept: '' }
        });
    }

    function addChecks(event) {
        setFormData(prevFormData => ({
            ...prevFormData,
            dataContent: event
        }));
    }

    function addTopicContent(event) {
        setFormData(prevFormData => ({
            ...prevFormData,
            topicContent: event
        }));
        console.log(event);
    }

    function removeChecks(event) {
        setFormData(prevFormData => ({
            ...prevFormData,
            dataContent: { dataType: '', chapterName: '', data: '' }
        }));
    }


    const project = () => {
        var selectDataPage = data == 'Verse'
            ? <SelectQuranData prevStep={prevStep} nextStep={nextStep} dataContent={dataContent} addChecks={addChecks}/>
            : <SelectHadithData prevStep={prevStep} nextStep={nextStep} dataContent={dataContent} addChecks={addChecks} removeChecks={removeChecks}/>

        switch(step) {
            case 1: return <SelectDataType prevStep={prevStep} nextStep={nextStep} handleOptionChange={handleOptionChange} data={data} dataType={dataType} />;
            case 2: return selectDataPage
            case 3: return <SelectTopic prevStep={prevStep} nextStep={nextStep} handleChange={handleChange} addTopicContent={addTopicContent} topicContent={topicContent}/>;
            case 4: return <Finish prevStep={prevStep} nextStep={nextStep} formData={formData}/>;
            default: return <Thanks />
        }
    }

    return(
        <section id='ontologyForm'>
            <Sidebar step={step} />
                {project()}
        </section>
    )
}

export default OntologyForm