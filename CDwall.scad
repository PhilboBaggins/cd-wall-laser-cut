
// https://en.wikipedia.org/wiki/Optical_disc_packaging#Jewel_case
CD_CASE_SIZE = [142, 125, 10];

DEFAULT_NUM_CD_X = 4;
DEFAULT_NUM_CD_Y = 2;

DEFAULT_SPACING_X = 10;
DEFAULT_SPACING_Y = 10;

DEFAULT_HOLDER_THICKNESS = 9;
DEFAULT_COVER_THICKNESS = 1;

DEFAULT_EXTRA_CUT_OUT = [1, 1];

HOLDER_COLOUR = "orange";
COVER_COLOUR = "grey";
HOLDER_ALPHA = 1.0;
COVER_ALPHA = 0.25;

module JewelCase(extraCutOut)
{
    extraCutOut = [extraCutOut[0], extraCutOut[1], 0];

    color(rands(0, 1.0, 3))
    cube(CD_CASE_SIZE + extraCutOut);
}

module ArrayOfJewelCases(numCDX, numCDY, spacingX, spacingY, extraCutOut)
{
    for (x = [0 : 1 : numCDX - 1])
    for (y = [0 : 1 : numCDY - 1])
    {
        xPos = x * (CD_CASE_SIZE[0] + spacingX + extraCutOut[0]);
        yPos = y * (CD_CASE_SIZE[1] + spacingY + extraCutOut[1]);

        translate([xPos, yPos, 0])
        JewelCase(extraCutOut);
    }
}

module Panel(numCDX, numCDY, spacingX, spacingY, thickness, extraCutOut, colour, alpha, includeCDHoles)
{
    xSize = CD_CASE_SIZE[0] * numCDX + spacingX * (numCDX + 1);
    ySize = CD_CASE_SIZE[1] * numCDY + spacingY * (numCDY + 1);

    echo(str("Panel is ", xSize, " mm by ", ySize, " mm"));

    color(colour, alpha)
    difference()
    {
        cube([xSize, ySize, thickness]);

        if (includeCDHoles)
        {
            // Holes for jewel cases
            translate([spacingX, spacingY, 0])
            ArrayOfJewelCases(numCDX, numCDY, spacingX, spacingY, extraCutOut);
        }
    }
}

module Holder(numCDX, numCDY, spacingX, spacingY, thickness, extraCutOut)
{
    Panel(numCDX, numCDY, spacingX, spacingY, thickness, extraCutOut, HOLDER_COLOUR, HOLDER_ALPHA, true);
}

module Cover(numCDX, numCDY, spacingX, spacingY, thickness)
{
    Panel(numCDX, numCDY, spacingX, spacingY, thickness, [0, 0], COVER_COLOUR, COVER_ALPHA, false);
}

module CDwall(
    numCDX = DEFAULT_NUM_CD_X,
    numCDY = DEFAULT_NUM_CD_Y,
    spacingX = DEFAULT_SPACING_X,
    spacingY = DEFAULT_SPACING_Y,
    holderThickness = DEFAULT_HOLDER_THICKNESS,
    coverThickness = DEFAULT_COVER_THICKNESS,
    extraCutOut = DEFAULT_EXTRA_CUT_OUT)
{
    Cover(numCDX, numCDY, spacingX, spacingY, coverThickness);

    translate([0, 0, coverThickness])
    Holder(numCDX, numCDY, spacingX, spacingY, holderThickness, extraCutOut);

    translate([0, 0, coverThickness + holderThickness])
    Cover(numCDX, numCDY, spacingX, spacingY, coverThickness);

    // Jewel cases
    translate([spacingX, spacingY, coverThickness])
    ArrayOfJewelCases(numCDX, numCDY, spacingX, spacingY, extraCutOut);
}

module Holder2D(
    numCDX = DEFAULT_NUM_CD_X,
    numCDY = DEFAULT_NUM_CD_Y,
    spacingX = DEFAULT_SPACING_X,
    spacingY = DEFAULT_SPACING_Y,
    extraCutOut = DEFAULT_EXTRA_CUT_OUT)
{
    projection()
    Panel(numCDX, numCDY, spacingX, spacingY, DEFAULT_HOLDER_THICKNESS, extraCutOut, HOLDER_COLOUR, HOLDER_ALPHA, true);
}

module Cover2D(
    numCDX = DEFAULT_NUM_CD_X,
    numCDY = DEFAULT_NUM_CD_Y,
    spacingX = DEFAULT_SPACING_X,
    spacingY = DEFAULT_SPACING_Y)
{
    projection()
    Panel(numCDX, numCDY, spacingX, spacingY, DEFAULT_COVER_THICKNESS, [0, 0], COVER_COLOUR, COVER_ALPHA, false);
}

//CDwall();

//Holder2D();
//Cover2D();
