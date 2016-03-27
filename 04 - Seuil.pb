XIncludeFile "ImageFilter.pbi"

UsePNGImageDecoder()

;Image originale en couleur
Image = LoadImage(#PB_Any,"lena_color.png")

;Image de sortie
ImageOut = CopyImage(Image, #PB_Any)

;AFfichage de l'image originale
OpenWindow(0, 100, 100, ImageWidth(Image), ImageHeight(Image), "Original", #PB_Window_SystemMenu)
ImageGadget(0, 0, 0, ImageWidth(Image), ImageHeight(Image), ImageID(Image))


;Cr�ation d'un pointeur sur le format RAW de l'image
StartDrawing(ImageOutput(Image))
  *RawImage = CreateRawImage(ImageWidth(Image), ImageHeight(Image), DrawingBuffer(), #FORMAT_RGB)
StopDrawing()

;Process : Seuil ( 0 - 255)
SetRawImageThreshold(*RawImage, 100)

;Copie du r�sultat du process dans l'image de sortie  
StartDrawing(ImageOutput(ImageOut))
CopyMemory(GetRawImagePixelsPtr(*RawImage), DrawingBuffer(), ImageWidth(Image) * ImageHeight(Image) * 3 )
StopDrawing()

;Affichage du r�sultat
OpenWindow(1, 0, 0, ImageWidth(Image), ImageHeight(Image), "Seuil", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
ImageGadget(1, 0,0, ImageWidth(Image), ImageHeight(Image), ImageID(ImageOut))

Repeat : Until WaitWindowEvent(10) = #PB_Event_CloseWindow

; IDE Options = PureBasic 5.42 LTS (Windows - x64)
; CursorPosition = 30
; EnableUnicode
; EnableXP