import React, { useState } from 'react'
import "./styles.scss";
import { TextField} from '@mui/material';

import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";

import { useAuth } from '../../../hooks/useAuth';
import Thanks from './Thanks';

const schema = z.object({
    surahName: z.string()
                .min(1, { message: "Surah Name cannot be empty" }),
    surahNumber: z.coerce.number().int().positive(),
    totalVerses: z.coerce.number().int().positive(),
    origin: z.enum(["Makkah", "Madinah"]).default("Makkah")
});

function AddSurahForm(){
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
        data['euid']= user.uid;
        
        const completedFormData = { ...data, name: data.surahName, number: data.surahNumber, revealedIn: data.origin };
        delete completedFormData.surahName;
        delete completedFormData.surahNumber;
        delete completedFormData.origin;

        await fetch("http://192.168.56.1:48275/surahs", {
                method: "POST",
                headers: {
                "Content-Type": "application/json"
                },
                body: JSON.stringify(completedFormData)
            });
        setFlag(false);
    };

    function handleOptionChange(event){
        console.log(event.target.value);
        setValue('origin', event.target.value);
    }
    // const [selectedSurahOption, setSelectedSurahOption] = useState();
    // const [verseChecked, setVerseChecked] = useState(false);

    const [displayOptions, setDisplayOptions]= useState([{
        "status": false,
        "value":""
    },{
        "status": false,
        "value":""
    }]);
    //     const surahLabel = document.getElementsByName('surah-label')[0];

    //     const selectedSurahId = event.value;
    //     const selectedOption = surahOptions.find(option => option.value === selectedSurahId);

    //     setValue("surah", selectedSurahId);
    
    //     setSelectedSurahOption(selectedSurahId); 
        
    //     setDisplayOptions(prevDisplayOptions => {
    //         const updatedOptions = [
    //           {
    //             ...prevDisplayOptions[0], 
    //             value: selectedOption.label,
    //             status: true 
    //           },
    //           ...prevDisplayOptions.slice(1) 
    //         ];
    //         return updatedOptions;
    //       });
    
    //     surahLabel.classList.add('checked');
    //     surahLabel.classList.remove('error');
    // };

    // function checkValues(){
    //     console.log("Check values");
    //     // const surahLabel = document.getElementsByName('surah-label')[0];
    //     const messages = [];

    //     if (selectedSurahOption === '' || selectedSurahOption === null) {
    //         messages.push("Please Select Surah");
    //         surahLabel.classList.add('error')
    //     }
    //     return messages;
    // }
    
    // const onVerseNumberChange = (event, newValue) =>{
    //     console.log(`${event.type} event: the new value is ${newValue}`)
    //     const verseNumberLabel = document.getElementById('verse-number-label');
    //     setValue("verseNumber", newValue);
    //     console.log("Hello");
    //     verseNumberLabel.classList.remove('error');
    //     setDisplayOptions(prevDisplayOptions => [
    //         ...prevDisplayOptions.slice(0, 1),
    //         {
    //           ...prevDisplayOptions[1],
    //           value: newValue,
    //           status: true 
    //         },
    //       ]);
    //     setVerseChecked(true);
    // }  

    const form = () => {
        return (<>
            <div className='content data'>
                <h2>Add Surah</h2>
                <p>Please Enter the Data for the Surah</p>
                <form onSubmit={handleSubmit(processForm)}>
                    <TextField 
                        {...register("surahName", { required: true })}
                        fullWidth 
                        label="Surah Name" 
                        id={`filled-error fullWidth`}
                        variant="outlined" 
                        error={errors.surahName}
                        slotProps={{
                            label:{
                                className:"label-text"
                            },
                    
                        }}
                        InputProps={{
                            className:errors.surahName ? "error no-border" : ""
                        }}  
                    />
                    {errors.surahName?.message && <span className='error-text'>{errors.surahName?.message}</span>}

                    <TextField
                        {...register("surahNumber", { required: true })}
                        fullWidth 
                        id={`filled-error fullWidth outlined-number`}
                        label="Surah Number"
                        type="number"
                        error={errors.surahNumber}
                        InputLabelProps={{
                            shrink: true,
                        }}
                        InputProps={{
                            className:errors.surahNumber ? "error no-border" : ""
                        }}  
                    />
                    {errors.surahNumber?.message && <span className='error-text'>{errors.surahNumber?.message}</span>}      

                    <TextField
                        {...register("totalVerses", { required: true })}
                        fullWidth 
                        id={`filled-error fullWidth outlined-number`}
                        label="Total Verses"
                        type="number"
                        error={errors.totalVerses}
                        InputLabelProps={{
                            shrink: true,
                        }}
                        InputProps={{
                            className:errors.totalVerses ? "error no-border" : ""
                        }}  
                    />
                   {errors.totalVerses?.message && <span className='error-text'>{errors.totalVerses?.message}</span>}
                   <label>Select Surah's origin</label>
                    <div className="options">
                        <div className="option">
                            <input 
                                type="radio" 
                                required  
                                name="origin" 
                                value="Makkah"
                                id="makkah" 
                                style={{visibility:"hidden", width:"0", height:"0"}}
                                onChange={handleOptionChange}
                                checked={true}
                            />
                            <label htmlFor="makkah">
                                <div className="imgBox">
                                    <img src="/assets/images/icon-quran.svg" alt="" />
                                </div>
                                <div className="info">
                                     <h5>Makkah</h5>
                                </div>
                            </label>
                        </div>
                        <div className="option">
                            <input 
                                type="radio" 
                                name="origin" 
                                id="madinah" 
                                value="Madinah"
                                style={{visibility:"hidden", width:"0", height:"0"}}
                                // checked={data.origin === 'Madinah'}
                                onChange={handleOptionChange}
                            />
                            <label htmlFor="madinah">
                                <div className="imgBox">
                                    <img src="/assets/images/icon-hadith.svg" alt="" />
                                </div>
                                <div className="info">
                                     <h5>Madinah</h5>
                                </div>
                            </label>
                        </div>
                        
                    </div>

                    <div className="buttons">
                        <input type="submit" value="Create Surah" />
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



export default AddSurahForm