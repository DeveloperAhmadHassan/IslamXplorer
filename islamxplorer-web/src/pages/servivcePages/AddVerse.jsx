import React from "react";
import AddVerseForm from '../../components/forms/addContentForms/AddVerseForm'
import UpdateVerseForm from "../../components/forms/addContentForms/UpdateVerseForm";
import { useParams } from "react-router-dom";

export const AddVerse = (props) => {
  const params = useParams();
  const idExists = params.id;
  return (
    <React.Fragment>
      {props.update ? <UpdateVerseForm id={idExists}/> : <AddVerseForm/>}
    </React.Fragment>
  );
};