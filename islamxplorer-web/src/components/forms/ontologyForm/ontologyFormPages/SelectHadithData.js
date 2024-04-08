import React, { useEffect, useState } from 'react'
import surahsData from './surahsData.json';
import useSurahs from '../../../../hooks/UseSurahs';
import useVerses from '../../../../hooks/UseVerses';
import Select from "react-select";
import useSources from '../../../../hooks/UseHadithSource';
import useChapters from '../../../../hooks/UseHadithSourceChapters';
import useHadith from '../../../../hooks/UseHadiths';

function SelectHadithData(props){
    
    function handleSubmit(e){
        e.preventDefault()
        if(checkValues().length == 0)
        {
            props.addChecks({
                "type": "hadith",
                "chapterName":selectedSourceOption,
                "data":selectedHadithOption,
                "extra":[selectedChapterOption]
            });
            props.nextStep()
        }
    }
    function checkValues(){
        const sourceLabel = document.getElementsByName('source-label')[0];
        const chapterLabel = document.getElementsByName('chapter-label')[0];
        const hadithLabel = document.getElementsByName('hadith-label')[0];
        const messages = [];

        if (selectedSourceOption == '' || selectedSourceOption == null) {
            messages.push("Please Select Hadith Source");
            sourceLabel.classList.add('error')
        }
        if (selectedChapterOption == '' || selectedChapterOption == null) {
            messages.push("Please Select a Chapter");
            chapterLabel.classList.add('error')
        }
        if (selectedHadithOption == '' || selectedHadithOption == null) {
            messages.push("Please Select a Hadith");
            hadithLabel.classList.add('error')
        }
    
        return messages;
    }

    const [selectedSourceOption, setSelectedSourceOption] = useState(props.dataContent?.chapterName);
    const [selectedChapterOption, setSelectedChapterOption] = useState(props.dataContent?.extra[0]);
    const [selectedHadithOption, setSelectedHadithOption] = useState(props.dataContent?.data);

    const { sourceOptions, isLoadingSources } = useSources();
    const { chapterOptions, isLoadingChapters } = useChapters({source: selectedSourceOption});
    const { hadithOptions, isLoadingHadiths } = useHadith({chapter: selectedChapterOption});

    const [displayOptions, setDisplayOptions]= useState([{
        "status": false,
        "value":""
    },{
        "status": false,
        "value":""
    },{
        "status": false,
        "value":""
    }]);


    const handleSurahChange = (event) => {
        const sourcelabel = document.getElementsByName('source-label')[0];
        const chapterLabel = document.getElementsByName('chapter-label')[0];
        const hadithLabel = document.getElementsByName('hadith-label')[0];

        const selectedSourceId = event.value;
        const selectedOption = sourceOptions.find(option => option.value === selectedSourceId);
    
        setSelectedSourceOption(selectedSourceId); 
        
        setDisplayOptions(prevDisplayOptions => [
            {
                value: selectedOption.label,
                status:true 
            },
            {
                value: '',
                status:false
            },
            {
                value: '',
                status:false
            }
        ]);
    
        sourcelabel.classList.add('checked');
        sourcelabel.classList.remove('error');
        chapterLabel.classList.remove('checked');
        chapterLabel.classList.remove('error');
        hadithLabel.classList.remove('checked');
        hadithLabel.classList.remove('error');

        setSelectedChapterOption('')
        setSelectedHadithOption('');
    };

    const handleVerseChange = (event) => {
        const chapterLabel = document.getElementsByName('chapter-label')[0];
        const hadithLabel = document.getElementsByName('hadith-label')[0];

        setSelectedChapterOption(event.value);

        const selectedOption = chapterOptions.find(option => option.value === event.value);

        setDisplayOptions(prevDisplayOptions => [
            {
                value: prevDisplayOptions[0].value,
                status: prevDisplayOptions[0].status
            },
            {
                value: selectedOption.value,
                status: true 
            },
            {
                value: "",
                status: false
            }
          ]);

        chapterLabel.classList.add('checked');
        chapterLabel.classList.remove('error');

        hadithLabel.classList.remove('checked');
        hadithLabel.classList.remove('error');

        setSelectedHadithOption('')
    };

    const handleHadithChange = (event) => {
        const hadithLabel = document.getElementsByName('hadith-label')[0];

        setSelectedHadithOption(event.value);

        const selectedOption = hadithOptions.find(option => option.value === event.value);

        console.log(selectedOption.value);

        setDisplayOptions(prevDisplayOptions => [
            ...prevDisplayOptions.slice(0, 2),
            {
              ...prevDisplayOptions[2],
              value: selectedOption.value,
              status: true 
            },
          ]);

        hadithLabel.classList.add('checked');
        hadithLabel.classList.remove('error');
    };

    return(
        <div className="content data" id='no-box-shadow'>
            <h2>Hadith Data</h2>
            <p>Select the Hadith source and Hadith for your Ontology</p>
            <form onSubmit={handleSubmit}>
                <label htmlFor="source-data" name="source-label" className={props.dataContent?.chapterName != '' ? 'checked' : ''}>
                    {!isLoadingSources && <p className='label-text'>Select Source</p>}

                    {isLoadingSources 
                    ?(<div id='loading'><p>Loading....</p></div>)
                    :(
                        
                        <div className="dropdown">
                        {console.log(sourceOptions)}
                            <Select 
                                options={sourceOptions} 
                                onChange={handleSurahChange} 
                                isLoading={isLoadingSources}
                                defaultValue={sourceOptions.find(option => option.value === selectedSourceOption)}
                            />
                        </div>
                    )}
    
                    <div>{
                        displayOptions[0].status && (<div id='selectedSurahOptionDisplay' className='label-text selected-text '> <span>Selected Source:</span> {displayOptions[0].value}</div>)
                    }</div>
                </label>
                <label htmlFor="chapter-data" name="chapter-label" className={(props.dataContent?.extra[0])? 'checked' : ''}>
                    {!isLoadingChapters && <p className='label-text'>Select Chapter</p>}

                    {isLoadingChapters 
                    ?(<div id='loading'><p>Loading....</p></div>)
                    :(
                        <div className="dropdown">
                            <Select 
                                options={chapterOptions} 
                                onChange={handleVerseChange} 
                                disabled={isLoadingChapters}
                                noOptionsMessage={() => "Select a Source from above..."}
                                defaultValue={chapterOptions.find(option => option.value === selectedChapterOption)}
                            />
                        </div>
                    )}

                    <div>{
                        displayOptions[1].status && (<div id='selectedVerseOptionDisplay' className='selected-text label-text'> <span>Selected Chapter:</span> {displayOptions[1].value}</div>)
                    }</div>
                </label>
                <label htmlFor="hadith-data" name="hadith-label" className={props.dataContent?.data !== '' ? 'checked' : ''}>
                    {!isLoadingHadiths && <p className='label-text'>Select Hadith</p>}
                    
                    {isLoadingHadiths
                    ?(<div id='loading'><p>Loading....</p></div>)
                    :(
                        <div className="dropdown">
                            <Select 
                                options={hadithOptions} 
                                onChange={handleHadithChange} 
                                disabled={isLoadingHadiths}
                                noOptionsMessage={() => "Select a Chapter from above..."}
                                defaultValue={hadithOptions.find(option => option.value === selectedHadithOption)}
                            />
                        </div>
                    )}

                    <div>{
                        displayOptions[2].status && (<div id='selectedHadithOptionDisplay' className='selected-text label-text'> <span>Selected Hadith:</span> {displayOptions[2].value}</div>)
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

export default SelectHadithData