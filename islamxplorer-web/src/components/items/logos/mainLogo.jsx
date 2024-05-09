import { Link } from "react-router-dom";
import logo from "../../../assets/icons/main-logo.png";
import './styles.scss';

export const MainLogo = () =>{
    return (<>
        <Link to={'/'}>
            <img src={logo} className={'main-logo'}/>
        </Link>
    </>);
}