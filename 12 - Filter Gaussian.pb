XIncludeFile "ImageFilter.pbi"

UsePNGImageDecoder()

factor.d = 1.0/(13.0*5.0) 
bias.d = 0
filterWidth = 5
filterHeight = 5

*Gaussian  = CreateFilter(filterWidth, filterHeight, factor, bias, ?filter_Gaussian)

;Image originale en couleur
Image = LoadImage(#PB_Any,"lena_color.png")

;Image de sortie
ImageOut = CopyImage(Image, #PB_Any)

;AFfichage de l'image originale
;AFfichage de l'image originale
OpenWindow(0, 100, 100, ImageWidth(Image), ImageHeight(Image), "Original", #PB_Window_SystemMenu)
ImageGadget(0, 0, 0, ImageWidth(Image), ImageHeight(Image), ImageID(Image))

;Création d'un pointeur sur le format RAW de l'image
StartDrawing(ImageOutput(Image))
*RawImage = CreateRawImage(ImageWidth(Image), ImageHeight(Image), DrawingBuffer(), #FORMAT_RGB)
StopDrawing()

;Flou en 3 passes
For i = 0 To 2
  ApplyFilter(*RawImage, *Gaussian)
Next

;Copie du résultat du process dans l'image de sortie  
StartDrawing(ImageOutput(ImageOut))
CopyMemory(GetRawImagePixelsPtr(*RawImage), DrawingBuffer(), ImageWidth(Image) * ImageHeight(Image) * 3 )
StopDrawing()

;Affichage du résultat
OpenWindow(1, 0, 0, ImageWidth(Image), ImageHeight(Image), "Flou Gaussian", #PB_Window_SystemMenu | #PB_Window_ScreenCentered) 
ImageGadget(1, 0, 0, ImageWidth(Image), ImageHeight(Image), ImageID(ImageOut))

Repeat : Until WaitWindowEvent(10) = #PB_Event_CloseWindow

DataSection  
  filter_Gaussian:
  
  Data.d  0,0,5,0,0
  Data.d	0,5,5,5,0
  Data.d	5,5,5,5,5
  Data.d	0,5,5,5,0
  Data.d	0,0,5,0,0	
  
EndDataSection

; IDE Options = PureBasic 5.42 LTS (Windows - x64)
; CursorPosition = 46
; FirstLine = 10
; EnableUnicode
; EnableXP