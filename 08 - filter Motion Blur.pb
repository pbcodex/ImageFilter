;http://lodev.org/cgtutor/filtering.html#Motion_Blur_

XIncludeFile "ImageFilter.pbi"

UsePNGImageDecoder()

factor.d = 1.0 / 7.0
bias.d = 1.0
filterWidth = 9
filterHeight = 9

*MotionBlur  = CreateFilter(filterWidth, filterHeight, factor, bias, ?filter_MotionBlur)

;Image originale en couleur
Image = LoadImage(#PB_Any,"lena_color.png")

;Image de sortie
ImageOut = CopyImage(Image, #PB_Any)

;AFfichage de l'image originale
OpenWindow(0, 100, 100, ImageWidth(Image), ImageHeight(Image), "Original", #PB_Window_SystemMenu)
ImageGadget(0, 0, 0, ImageWidth(Image), ImageHeight(Image), ImageID(Image))

;Création d'un pointeur sur le format RAW de l'image
StartDrawing(ImageOutput(Image))
*RawImage = CreateRawImage(ImageWidth(Image), ImageHeight(Image), DrawingBuffer(), #FORMAT_RGB)
StopDrawing()

ApplyFilter(*RawImage, *MotionBlur)

;Copie du résultat du process dans l'image de sortie
StartDrawing(ImageOutput(ImageOut))
CopyMemory(GetRawImagePixelsPtr(*RawImage), DrawingBuffer(), ImageWidth(Image) * ImageHeight(Image) * 3 )
StopDrawing()

;Affichage du résultat
OpenWindow(1, 0, 0, ImageWidth(Image), ImageHeight(Image), "Motion Blur", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
ImageGadget(1, 0, 0, ImageWidth(Image), ImageHeight(Image), ImageID(ImageOut))

Repeat : Until WaitWindowEvent(10) = #PB_Event_CloseWindow

DataSection  
  filter_MotionBlur:
  
  Data.d 1, 0, 0, 0, 0, 0, 0, 0, 0
  Data.d 0, 1, 0, 0, 0, 0, 0, 0, 0
  Data.d 0, 0, 1, 0, 0, 0, 0, 0, 0
  Data.d 0, 0, 0, 1, 0, 0, 0, 0, 0
  Data.d 0, 0, 0, 0, 1, 0, 0, 0, 0
  Data.d 0, 0, 0, 0, 0, 1, 0, 0, 0
  Data.d 0, 0, 0, 0, 0, 0, 1, 0, 0
  Data.d 0, 0, 0, 0, 0, 0, 0, 1, 0
  Data.d 0, 0, 0, 0, 0, 0, 0, 0, 1
  
EndDataSection

; IDE Options = PureBasic 5.42 LTS (Windows - x64)
; CursorPosition = 51
; FirstLine = 23
; EnableUnicode
; EnableXP