XIncludeFile "ImageFilter.pbi"

UsePNGImageDecoder()

;Image originale en couleur
Image = LoadImage(#PB_Any,"lena_color.png")

;AFfichage de l'image originale
OpenWindow(0, 100, 100, ImageWidth(Image), ImageHeight(Image), "Original", #PB_Window_SystemMenu)
ImageGadget(0, 0, 0, ImageWidth(Image), ImageHeight(Image), ImageID(Image))

;Cr�ation d'un pointeur sur le format RAW de l'image
StartDrawing(ImageOutput(Image))
  *RawImage = CreateRawImage(ImageWidth(Image), ImageHeight(Image), DrawingBuffer(), #FORMAT_RGB)
StopDrawing()

;Process : Inverse (0 � 255)
RawImageGenerateNormalMapping(*RawImage, 20)

;Copie du r�sultat du process dans l'image d'origine  
StartDrawing(ImageOutput(Image))
CopyMemory(GetRawImagePixelsPtr(*RawImage), DrawingBuffer(), ImageWidth(Image) * ImageHeight(Image) * 3 )
StopDrawing()

;Affichage du r�sultat
OpenWindow(1, 0, 0, ImageWidth(Image), ImageHeight(Image), "Normal Map", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
ImageGadget(1, 0,0, ImageWidth(Image), ImageHeight(Image), ImageID(Image))

Repeat : Until WaitWindowEvent(10) = #PB_Event_CloseWindow

; IDE Options = PureBasic 5.42 LTS (Windows - x86)
; CursorPosition = 25
; EnableUnicode
; EnableXP