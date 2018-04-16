# Crop eps by pdf
epstopdf result.eps
pdfcrop result.pdf
pdftops -eps result-crop.pdf result.eps
rm result-crop.pdf result.pdf
