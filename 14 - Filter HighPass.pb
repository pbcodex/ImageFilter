;http://softwarebydefault.com/2013/05/01/image-convolution-filters/

XIncludeFile "ImageFilter.pbi"

UseJPEGImageDecoder()

factor.d = 1.0 / 16.0  
bias.d = 128.0
filterWidth = 3
filterHeight = 3

*HighPass  = CreateFilter(filterWidth, filterHeight, factor, bias, ?filter_HighPass)

;Image originale en couleur
Image = LoadImage(#PB_Any,"parot.jpg")

;Image de sortie
ImageOut = CopyImage(Image, #PB_Any)

;AFfichage de l'image originale
OpenWindow(0, 100, 100, ImageWidth(Image), ImageHeight(Image), "Original", #PB_Window_SystemMenu)
ImageGadget(0, 0, 0, ImageWidth(Image), ImageHeight(Image), ImageID(Image))

;Création d'un pointeur sur le format RAW de l'image
StartDrawing(ImageOutput(Image))
*RawImage = CreateRawImage(ImageWidth(Image), ImageHeight(Image), DrawingBuffer(), #FORMAT_RGB)
StopDrawing()

ApplyFilter(*RawImage, *HighPass)

;Copie du résultat du process dans l'image de sortie  
StartDrawing(ImageOutput(ImageOut))
CopyMemory(GetRawImagePixelsPtr(*RawImage), DrawingBuffer(), ImageWidth(Image) * ImageHeight(Image) * 3 )
StopDrawing()

;Affichage du résultat
OpenWindow(1, 0, 0, ImageWidth(Image), ImageHeight(Image), "High Pass", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
ImageGadget(1, 0,0, ImageWidth(Image), ImageHeight(Image), ImageID(ImageOut))

Repeat : Until WaitWindowEvent(10) = #PB_Event_CloseWindow

DataSection  
  filter_HighPass:
  
  Data.d  -1.0, -2.0, -1.0
  Data.d  -2.0, 12, -2
  Data.d  -1.0, -2.0, -1.0
  
EndDataSection

; IDE Options = PureBasic 5.42 LTS (Windows - x86)
; CursorPosition = 36
; EnableUnicode
; EnableXP