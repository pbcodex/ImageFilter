;http://lodev.org/cgtutor/filtering.html#Emboss

XIncludeFile "ImageFilter.pbi"

UsePNGImageDecoder()

factor.d = 1 
bias.d = 128
filterWidth = 3
filterHeight = 3

*Emboss  = CreateFilter(filterWidth, filterHeight, factor, bias, ?filter_Emboss)

;Image originale en couleur
Image = LoadImage(#PB_Any,"lena_color.png")

;AFfichage de l'image originale
OpenWindow(0, 100, 100, ImageWidth(Image), ImageHeight(Image), "Original", #PB_Window_SystemMenu)
ImageGadget(0, 0, 0, ImageWidth(Image), ImageHeight(Image), ImageID(Image))

;Création d'un pointeur sur le format RAW de l'image
StartDrawing(ImageOutput(Image))
*RawImage = CreateRawImage(ImageWidth(Image), ImageHeight(Image), DrawingBuffer(), #FORMAT_RGB)
StopDrawing()

ApplyFilter(*RawImage, *Emboss)

;Copie du résultat du process dans l'image d'origine  
StartDrawing(ImageOutput(Image))
CopyMemory(GetRawImagePixelsPtr(*RawImage), DrawingBuffer(), ImageWidth(Image) * ImageHeight(Image) * 3 )
StopDrawing()

;Affichage du résultat
OpenWindow(1, 0, 0, ImageWidth(Image), ImageHeight(Image), "Emboss", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
ImageGadget(1, 0, 0, ImageWidth(Image), ImageHeight(Image), ImageID(Image))

Repeat : Until WaitWindowEvent(10) = #PB_Event_CloseWindow

DataSection  
  filter_Emboss:
  
  Data.d -1, -1,  0
  Data.d -1,  0,  1
  Data.d  0,  1,  1
  
EndDataSection

; IDE Options = PureBasic 5.42 LTS (Windows - x86)
; CursorPosition = 34
; EnableUnicode
; EnableXP