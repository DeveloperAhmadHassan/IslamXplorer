import { Link } from "react-router-dom";
import logo from "../../../assets/icons/primary-logo.png";
import './styles.scss';

export const PrimaryLogo = () =>{
    return (<>
        <Link to={'/'}>
            <img src={logo} className={'primary-logo'}/>
        </Link>
    </>);
}