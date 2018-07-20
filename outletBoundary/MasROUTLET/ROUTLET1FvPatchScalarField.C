/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | Copyright (C) 2018 OpenFOAM Foundation
     \\/     M anipulation  |
-------------------------------------------------------------------------------
License
    This file is part of OpenFOAM.

    OpenFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.

\*---------------------------------------------------------------------------*/

#include "ROUTLET1FvPatchScalarField.H"
#include "addToRunTimeSelectionTable.H"
#include "fvPatchFieldMapper.H"
#include "volFields.H"
#include "surfaceFields.H"

// * * * * * * * * * * * * * Private Member Functions  * * * * * * * * * * * //

namespace Foam
{

    Foam::scalar Foam::ROUTLET1FvPatchScalarField::t() const
    {
        return db().time().timeOutputValue();
    }   


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

    Foam::ROUTLET1FvPatchScalarField::
    ROUTLET1FvPatchScalarField
    (
        const fvPatch& p,
        const DimensionedField<scalar, volMesh>& iF
    )
    :
    fixedValueFvPatchScalarField(p, iF),
    z_(p.size(), Zero)
    {
    }

    Foam::ROUTLET1FvPatchScalarField::
    ROUTLET1FvPatchScalarField
    (
        const ROUTLET1FvPatchScalarField& ptf,
        const fvPatch& p,
        const DimensionedField<scalar, volMesh>& iF,
        const fvPatchFieldMapper& mapper
    )
    :
        fixedValueFvPatchScalarField(ptf, p, iF, mapper),
        z_(ptf.z_, mapper)
    {}

    Foam::ROUTLET1FvPatchScalarField::
    ROUTLET1FvPatchScalarField
    (
        const fvPatch& p,
        const DimensionedField<scalar, volMesh>& iF,
        const dictionary& dict
    )
    :
        fixedValueFvPatchScalarField(p, iF),
        z_("z", dict, p.size())
        
    {


    //    fixedValueFvPatchScalarField::evaluate();

    
    //Initialise with the value entry if evaluation is not possible
    fvPatchScalarField::operator=
    (
        scalarField("value", dict, p.size())
    );
    
    }


    

    Foam::ROUTLET1FvPatchScalarField::
    ROUTLET1FvPatchScalarField
    (
        const ROUTLET1FvPatchScalarField& ptf
    )
    :
    fixedValueFvPatchScalarField(ptf),
    z_(ptf.z_)
    {}


    Foam::ROUTLET1FvPatchScalarField::
    ROUTLET1FvPatchScalarField
    (
        const ROUTLET1FvPatchScalarField& ptf,
        const DimensionedField<scalar, volMesh>& iF
    )
    :
        fixedValueFvPatchScalarField(ptf, iF),
        z_(ptf.z_)
    {}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

    void Foam::ROUTLET1FvPatchScalarField::autoMap
    (
        const fvPatchFieldMapper& m
    )
    {
        fixedValueFvPatchScalarField::autoMap(m);
    }


    void Foam::ROUTLET1FvPatchScalarField::rmap
    (
    const fvPatchScalarField& ptf,
    const labelList& addr
    )
    {
        fixedValueFvPatchScalarField::rmap(ptf, addr);

    }

    void Foam::ROUTLET1FvPatchScalarField::updateCoeffs()
    {
        if (updated())
        {
            Info << "P has already been updated" << endl;
            return;
        }
Info << "******Updating Pressure boundary condition*******" << endl;
label patchId = patch().boundaryMesh().findPatchID("OUT1");
Info<<"--->>---->>---->> outlet patch ID = "<<patchId<<endl;
const surfaceScalarField& my_phi = db().lookupObject<surfaceScalarField>("phi");
const scalarField& outphi = my_phi.boundaryField()[patchId];
Info << "--->>---->>---->> Flux from OUT1 = " <<sum(outphi)<<endl;
        fixedValueFvPatchScalarField::operator==
        (
         z_ * sum(outphi)
        );
Info << "******Updated Pressure boundary condition*******" << endl;
    fixedValueFvPatchScalarField::updateCoeffs();
    }


    void Foam::ROUTLET1FvPatchScalarField::write
    (
        Ostream& os
    ) const
    {
        fvPatchScalarField::write(os);
        z_.writeEntry("z", os);
        writeEntry("value", os);
    }


// * * * * * * * * * * * * * * Build Macro Function  * * * * * * * * * * * * //

//namespace Foam
//{
    makePatchTypeField
    (
        fvPatchScalarField,
        ROUTLET1FvPatchScalarField
    );
}

// ************************************************************************* //
