import React from 'react'

function Pickons(props){
    
    function handleSubmit(e){
        e.preventDefault()
        props.nextStep()
    }
    function handleChange(event){
        
         if(event.target.checked){
            props.addChecks(event)
         }else{
            props.removeChecks(event)
         }
    }

    return(
        <div className="content pickons">
            <h2>Pick add-ons</h2>
            <p>Add-ons help enhance your gaming experience</p>
            <form onSubmit={handleSubmit}>
                <label htmlFor="online-service" className={props.pickons.find((pickon) => pickon === 'online service') === 'online service' ? 'checked' : ''} >
                    <input 
                        type="checkbox" 
                        name="pickon" 
                        className='pickon'
                        value="online service"
                        id="online-service" 
                        onChange={handleChange}
                        checked={props.pickons.find((pickon) => pickon === 'online service') === 'online service'}
                    />
                    <div className="info">
                        <h5>Online service</h5>
                        <p>Access to multiplayer games</p>
                    </div>
                    <div className="price">+ $1/mo</div>
                </label>
                <label htmlFor="larger-storage" className={props.pickons.find((pickon) => pickon === 'larger storage') === 'larger storage' ? 'checked' : ''}>
                    <input 
                        type="checkbox" 
                        name="pickon" 
                        className="pickon"
                        id="larger-storage" 
                        value="larger storage"
                        onChange={handleChange}
                        checked={props.pickons.find((pickon) => pickon === 'larger storage') === 'larger storage'}

                    />
                    <div className="info">
                        <h5>Larger storage</h5>
                        <p>Extra 1TB of cloud save</p>
                    </div>
                    <div className="price">+ $2/mo</div>
                </label>
                <label htmlFor="custom" className={props.pickons.find((pickon) => pickon === 'customizable profile') === 'customizable profile' ? 'checked' : ''}>
                    <input 
                        type="checkbox" 
                        name="pickon" 
                        className='pickon'
                        id="custom" 
                        value="customizable profile"
                        onChange={handleChange}
                        checked={props.pickons.find((pickon) => pickon === 'customizable profile') === 'customizable profile'}

                    />
                    <div className="info">
                        <h5>Customizable Profile</h5>
                        <p>Custom theme on your profile</p>
                    </div>
                    <div className="price">+ $2/mo</div>
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

export default Pickons