import React, { useEffect, useState } from 'react'
import surahsData from './surahsData.json';
import useSurahs from '../../../../hooks/UseSurahs';
import useVerses from '../../../../hooks/UseVerses';
import Select from "react-select";

function SelectQuranData(props){
    
    function handleSubmit(e){
        e.preventDefault()
        if(checkValues().length == 0)
        {
            props.addChecks({
                "type": "quran",
                "chapterName":selectedSurahOption,
                "data":selectedVerseOption
            });
            props.nextStep()
        }
    }
    function checkValues(){
        const surahLabel = document.getElementsByName('surah-label')[0];
        const verseLabel = document.getElementsByName('verse-label')[0];
        const messages = [];

        if (selectedSurahOption == '' || selectedSurahOption == null) {
            messages.push("Please Select Surah");
            console.log("Please Select Surah");
            surahLabel.classList.add('error')
        }
        if (selectedVerseOption == '' || selectedVerseOption == null) {
            messages.push("Please Select Verse");
            console.log("Please Select Verse");
            verseLabel.classList.add('error')
        }
    
        return messages;
    }

    const [selectedSurahOption, setSelectedSurahOption] = useState(props.dataContent?.chapterName);
    const [selectedVerseOption, setSelectedVerseOption] = useState(props.dataContent?.data);

    const { surahOptions, isLoadingSurahs } = useSurahs();
    const { verseOptions, isLoadingVerses } = useVerses({id: selectedSurahOption});

    const [displayOptions, setDisplayOptions]= useState([{
        "status": false,
        "value":""
    },{
        "status": false,
        "value":""
    }]);


    const handleSurahChange = (event) => {
        const surahLabel = document.getElementsByName('surah-label')[0];
        const verseLabel = document.getElementsByName('verse-label')[0];

        const selectedSurahId = event.value;
        const selectedOption = surahOptions.find(option => option.value === selectedSurahId);
    
        setSelectedSurahOption(selectedSurahId); 
        
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
    
        surahLabel.classList.add('checked');
        surahLabel.classList.remove('error');
        verseLabel.classList.remove('checked');
        verseLabel.classList.remove('error');

        setSelectedVerseOption('')
    };

    const handleVerseChange = (event) => {
        const verseLabel = document.getElementsByName('verse-label')[0];

        setSelectedVerseOption(event.value);

        const selectedOption = verseOptions.find(option => option.value === event.value);
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

        verseLabel.classList.add('checked');
        verseLabel.classList.remove('error');
    };

    return(
        <div className="content data" id='no-box-shadow'>
            <h2>Quran Data</h2>
            <p>Select the Surah and its Verse for your Ontology</p>
            <form onSubmit={handleSubmit}>
                <label htmlFor="surah-data" name="surah-label" className={props.dataContent?.chapterName != '' ? 'checked' : ''}>
                    {!isLoadingSurahs && <p className='label-text'>Select Surah</p>}
                    {isLoadingSurahs 
                    ?(<div id='loading'><p>Loading....</p></div>)
                    :(
                        
                        <div className="dropdown">
                        {console.log(surahOptions)}
                            <Select 
                                options={surahOptions} 
                                onChange={handleSurahChange} 
                                isLoading={isLoadingSurahs}
                                defaultValue={surahOptions.find(option => option.value === selectedSurahOption)}
                            />
                        </div>
                    )}
    
                    <div>{
                        displayOptions[0].status && (<div id='selectedSurahOptionDisplay' className='label-text selected-text '> <span>Selected Surah:</span> {displayOptions[0].value}</div>)
                    }</div>
                </label>
                <label htmlFor="verse-data" name="verse-label" className={props.dataContent?.data != '' ? 'checked' : ''}>
                    {!isLoadingVerses && <p className='label-text'>Select Verse</p>}
                    
                    {isLoadingVerses 
                    ?(<div id='loading'><p>Loading....</p></div>)
                    :(
                        <div className="dropdown">
                            <Select 
                                options={verseOptions} 
                                onChange={handleVerseChange} 
                                disabled={isLoadingVerses}
                                noOptionsMessage={() => "Select a Surah from above..."}
                                defaultValue={verseOptions.find(option => option.value === selectedVerseOption)}
                            />
                        </div>
                    )}

                    <div>{
                        displayOptions[1].status && (<div id='selectedVerseOptionDisplay' className='selected-text label-text'> <span>Selected Verse:</span> {displayOptions[1].value}</div>)
                    }</div>
                </label>
                
                <div className="buttons">
                    <input 
                        type="button" 
                        value="Go Back" 
                        onClick={props.prevStep} 
                    />
                    <input type="submit" value="Next Step" />
                </div>
            </form>
        </div>
    )
}

export default SelectQuranData