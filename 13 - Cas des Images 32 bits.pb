XIncludeFile "ImageFilter.pbi"

UsePNGImageDecoder()

;Image originale en couleur
Image = LoadImage(#PB_Any,"tomato.png")

;AFfichage de l'image originale
OpenWindow(0, 100, 100, ImageWidth(Image), ImageHeight(Image), "Original", #PB_Window_SystemMenu)
ImageGadget(0, 0, 0, ImageWidth(Image), ImageHeight(Image), ImageID(Image))

;Création d'un pointeur sur le format RAW de l'image
StartDrawing(ImageOutput(Image))
  If ImageDepth(image) = 24
    *RawImage = CreateRawImage(ImageWidth(Image), ImageHeight(Image), DrawingBuffer(), #FORMAT_RGB)
  EndIf 
  
  If ImageDepth(image) = 32
    *RawImage = CreateRawImage(ImageWidth(Image), ImageHeight(Image), DrawingBuffer(), #FORMAT_RGBA)
  EndIf 
StopDrawing()

;Process : Dégradé de gris
GrayScaleRawImage(*RawImage)

;Copie du résultat du process dans l'image d'origine  
StartDrawing(ImageOutput(Image))
  If ImageDepth(image) = 24
    CopyMemory(GetRawImagePixelsPtr(*RawImage), DrawingBuffer(), ImageWidth(Image) * ImageHeight(Image) * 3 )
  EndIf 
  
  If ImageDepth(image) = 32
    CopyMemory(GetRawImagePixelsPtr(*RawImage), DrawingBuffer(), ImageWidth(Image) * ImageHeight(Image) * 4 )
  EndIf   
StopDrawing()


;Affichage du résultat
OpenWindow(1, 0, 0, ImageWidth(Image), ImageHeight(Image), "GreyScale", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
ImageGadget(1, 0,0, ImageWidth(Image), ImageHeight(Image), ImageID(Image))

Repeat : Until WaitWindowEvent(10) = #PB_Event_CloseWindow

UsePNGImageEncoder()
SaveImage(Image, "test.png", #PB_ImagePlugin_PNG)
; IDE Options = PureBasic 5.42 LTS (Windows - x86)
; CursorPosition = 44
; FirstLine = 11
; EnableUnicode
; EnableXP