import React, { useState } from 'react'
import "./styles.scss";
import { TextField} from '@mui/material';
import Select from "react-select";


import useSurahs from '../../../hooks/UseSurahs';

import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";

import { Unstable_NumberInput as BaseNumberInput } from '@mui/base/Unstable_NumberInput';
import RemoveIcon from '@mui/icons-material/Remove';
import AddIcon from '@mui/icons-material/Add';
import { useAuth } from '../../../hooks/useAuth';
import Thanks from './Thanks';

const schema = z.object({
    arabicText: z.string()
                .min(1, { message: "Arabic text cannot be empty" }),
    englishText: z.string().min(1, { message: "English text cannot be empty" }).min(5).refine(value => /^[a-zA-Z\s\p{P}]+$/u.test(value), {
      message: "English text must contain English characters"
    }),
    verseNumber: z.coerce.number().int().positive(),
    surah: z.string() 
  });

function AddVerseForm(){
    const {
        register,
        handleSubmit,
        formState: { errors },
        setValue,
    } = useForm({
        resolver: zodResolver(schema)
    });

    const [flag, setFlag] = useState(true);

    const {user} = useAuth();

    const processForm = async (data) => {
        let {surah, verseNumber, ...completedFormData} = data;
        completedFormData["verseID"] = `${surah}:${verseNumber}`;
        completedFormData["uid"]=user.uid;
        completedFormData["surahNumber"]=surah;

        console.log(completedFormData);

        if(checkValues().length === 0){
            await fetch("http://192.168.56.1:48275/verses", {
                  method: "POST",
                  headers: {
                    "Content-Type": "application/json"
                  },
                  body: JSON.stringify(completedFormData)
                });
            setFlag(false);
        } else{
            console.log("error!!!!")
        }
    };

    const { surahOptions, isLoadingSurahs } = useSurahs();
    const [selectedSurahOption, setSelectedSurahOption] = useState();
    const [verseChecked, setVerseChecked] = useState(false);

    const [displayOptions, setDisplayOptions]= useState([{
        "status": false,
        "value":""
    },{
        "status": false,
        "value":""
    }]);

    const handleSurahChange = (event) => {
        const surahLabel = document.getElementsByName('surah-label')[0];

        const selectedSurahId = event.value;
        const selectedOption = surahOptions.find(option => option.value === selectedSurahId);

        setValue("surah", selectedSurahId);
    
        setSelectedSurahOption(selectedSurahId); 
        
        setDisplayOptions(prevDisplayOptions => {
            const updatedOptions = [
              {
                ...prevDisplayOptions[0], 
                value: selectedOption.label,
                status: true 
              },
              ...prevDisplayOptions.slice(1) 
            ];
            return updatedOptions;
          });
    
        surahLabel.classList.add('checked');
        surahLabel.classList.remove('error');
    };

    function checkValues(){
        console.log("Check values");
        const surahLabel = document.getElementsByName('surah-label')[0];
        const messages = [];

        if (selectedSurahOption === '' || selectedSurahOption === null) {
            messages.push("Please Select Surah");
            surahLabel.classList.add('error')
        }
        return messages;
    }
    
    const onVerseNumberChange = (event, newValue) =>{
        console.log(`${event.type} event: the new value is ${newValue}`)
        const verseNumberLabel = document.getElementById('verse-number-label');
        setValue("verseNumber", newValue);
        console.log("Hello");
        verseNumberLabel.classList.remove('error');
        setDisplayOptions(prevDisplayOptions => [
            ...prevDisplayOptions.slice(0, 1),
            {
              ...prevDisplayOptions[1],
              value: newValue,
              status: true 
            },
          ]);
        setVerseChecked(true);
    }  

    const form = () => {
        return (<>
            <div className='content data'>
                <h2>Add Verse</h2>
                <p>Please Enter the Data for the Verse</p>
                <form onSubmit={handleSubmit(processForm)}>
                    <label htmlFor="surah-data" name="surah-label" className={`label-border dropdown-label ${errors.surah ? 'error' : ''}`}>
                        {!isLoadingSurahs && <p className='label-text'>Select Surah</p>}
                        {isLoadingSurahs 
                        ?(<div id='loading'><p>Loading....</p></div>)
                        :(
                            
                            <div className="dropdown">
                                <Select 
                                    {...register("surah", { required: true })}
                                    options={surahOptions} 
                                    onChange={handleSurahChange} 
                                    isLoading={isLoadingSurahs}
                                    defaultValue={surahOptions.find(option => option.value === selectedSurahOption)}
                                />
                            </div>
                        )}
        
                        <div>{
                            displayOptions[0].status && (<div id='selectedSurahOptionDisplay' className='selected-text'> <span>Selected Surah:</span> {displayOptions[0].value}</div>)
                        }</div>
                    </label>
                    
                    <TextField 
                        {...register("arabicText", { required: true })}
                        fullWidth 
                        label="Arabic Text" 
                        id={`filled-error fullWidth`}
                        variant="outlined" 
                        error={errors.arabicText}
                        slotProps={{
                            label:{
                                className:"label-text"
                            },
                    
                        }}
                        InputProps={{
                            className:errors.arabicText ? "error no-border" : ""
                        }}
                        
                    />
                    {errors.arabicText?.message && <span className='error-text'>{errors.arabicText?.message}</span>}
                   
                    
                
                    <TextField 
                        {...register("englishText", { required: true })}
                        fullWidth 
                        label="English Text" 
                        id={`filled-error fullWidth`}
                        variant="outlined" 
                        error={errors.englishText}
                        slotProps={{
                            label:{
                                className:"label-text"
                            },
                            input:{
                                className:"something"
                            }
                        }}
                        InputProps={{
                            className:errors.englishText ? "error no-border" : ""
                        }}
                        
                    />
                    {errors.englishText?.message && <span className='error-text'>{errors.englishText?.message}</span>}

                    <label className={`label-border ${errors.verseNumber ? 'error' : ''} ${verseChecked ? 'checked' : ''}`} id='verse-number-label'>
                        <p className='label-text'>Verse Number</p>
                        <BaseNumberInput
                            slotProps={{
                                incrementButton: {
                                children: <AddIcon fontSize="small" />,
                                className: 'increment StyledButton',
                                },
                                root:{
                                    className:"StyledInputRoot"
                                },
                                input:{
                                    className:"StyledInput"
                                },
                                decrementButton: {
                                children: <RemoveIcon fontSize="small" />,
                                className:"StyledButton"
                                },
                            }}
                            onChange={onVerseNumberChange}
                            aria-label="Quantity Input" 
                                min={1} 
                                max={99}
                            />
                            <div>{
                                displayOptions[1].status && (<div id='selectedSurahOptionDisplay' className='selected-text'> {displayOptions[0].value} : {displayOptions[1].value}</div>)
                        }</div>
                    </label>

                    <div className="buttons">
                        <input type="submit" value="Add" />
                    </div> 
                </form>
            </div>
        </>)
    }

    return(
        <main id='addContentForm'>
            {flag ? form() : <Thanks />}
        </main>
    )
}



export default AddVerseForm