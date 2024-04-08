import React, { useState } from 'react'
import useTypes from '../../../../hooks/UseTypes';
import Select from 'react-select'
import useConcepts from '../../../../hooks/UseConcepts';

function SelectTopic(props){

   function handleSubmit(e){
      e.preventDefault()
      if(checkValues().length == 0)
      {
         props.addTopicContent({
            "type":selectedTypeOption,
            "concept":selectedConceptOption
         });
         props.nextStep()
      }
  }

   function checkValues(){
      const typeLabel = document.getElementsByName('type-label')[0];
      const conceptLabel = document.getElementsByName('concept-label')[0];
      const messages = [];

      if (selectedTypeOption == '' || selectedTypeOption == null) {
          messages.push("Please Select a Topic");
          console.log("Please Select a Concept");
          typeLabel.classList.add('error')
      }
      if (selectedConceptOption == '' || selectedConceptOption == null) {
          messages.push("Please Select a Concept");
          console.log("Please Select a Concept");
          conceptLabel.classList.add('error')
      }
  
      return messages;
  }

   const [selectedTypeOption, setSelectedTypeOption] = useState(props.topicContent?.type);
   const [selectedConceptOption, setSelectedConceptOption] = useState(props.topicContent?.concept);

   const { typeOptions, isLoadingTypes } = useTypes();
   const { conceptOptions, isLoadingConcepts } = useConcepts({id: selectedTypeOption});

   const [displayOptions, setDisplayOptions]= useState([{
      "status": false,
      "value":""
      },{
      "status": false,
      "value":""
   }]);

   const handleTypeChange = (event) => {
      const typeLabel = document.getElementsByName('type-label')[0];
      const conceptLabel = document.getElementsByName('concept-label')[0];

      const selectedTypeId = event.value;
      const selectedOption = typeOptions.find(option => option.value === selectedTypeId);
  
      setSelectedTypeOption(selectedTypeId); 
      
      setDisplayOptions(prevDisplayOptions => [
          {
              value: selectedOption.label,
              status:true 
          },
          {
              value: '',
              status:false
          }
      ]);
      
      console.log(displayOptions);
  
      typeLabel.classList.add('checked');
      typeLabel.classList.remove('error');
      conceptLabel.classList.remove('checked');
      conceptLabel.classList.remove('error');

      setSelectedConceptOption('')
   };

   const handleConceptChange = (event) => {
      const conceptLabel = document.getElementsByName('concept-label')[0];

      setSelectedConceptOption(event.value);

      const selectedOption = conceptOptions.find(option => option.value === event.value);
      console.log(selectedOption);

      setDisplayOptions(prevDisplayOptions => [
         ...prevDisplayOptions.slice(0, 1),
         {
            ...prevDisplayOptions[1],
            value: selectedOption.value,
            status: true 
         },
      ]);
      console.log(displayOptions);

      conceptLabel.classList.add('checked');
      conceptLabel.classList.remove('error');
   };

   return(
   <div className="content topicinfo" id='no-box-shadow'>
      <h2>Topic Data</h2>
      <p>Please provide the main Theme and its concept</p>
      <form onSubmit={handleSubmit}>
         <label htmlFor="type-data" name="type-label" className={props.topicContent?.type != '' ? 'checked' : ''}>
            {!isLoadingTypes && <p className='label-text'>Select Topic</p>}
            {isLoadingTypes 
            ?(<div id='loading'><p>Loading....</p></div>)
            :( 
               <div className="dropdown">
               {console.log(typeOptions)}
                     <Select 
                        options={typeOptions} 
                        onChange={handleTypeChange} 
                        defaultValue={typeOptions.find(option => option.value === selectedTypeOption)}
                     />
               </div>
            )}

            <div>{
               displayOptions[0].status && (<div id='selectedTypeOptionDisplay' className='label-text selected-text '> <span>Selected Topic:</span> {displayOptions[0].value}</div>)
            }</div>
         </label>

         <label htmlFor="concept-data" name="concept-label" className={props.topicContent?.concept != '' ? 'checked' : ''}>
            {!isLoadingConcepts && <p className='label-text'>Select Concept</p>}
            {isLoadingConcepts 
            ?(<div id='loading'><p>Loading....</p></div>)
            :(
               
               <div className="dropdown">
                     <Select 
                        options={conceptOptions} 
                        onChange={handleConceptChange} 
                        defaultValue={conceptOptions.find(option => option.value === selectedConceptOption)}
                     />
               </div>
            )}

            <div>{
               displayOptions[1].status && (<div id='selectedConceptOptionDisplay' className='label-text selected-text '> <span>Selected Concept:</span> {displayOptions[1].value}</div>)
            }</div>
         </label>
        
         <div className="buttons">
            <input type="button" value="Go Back" onClick={props.prevStep}/>
            <input type="submit" value="Next Step" />
         </div>
      </form>
   </div>
   )
}

export default SelectTopic