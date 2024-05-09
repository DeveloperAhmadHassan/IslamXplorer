import React, {} from 'react';
import { OntTable } from '../../components/tables/OntTable/OntTable';
import "./ont_styles.scss";

export const Ontologies = () => {

  return (
    <div className='data-table' id='ont-table'>
      <OntTable />
    </div>
  );
};