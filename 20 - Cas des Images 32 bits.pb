XIncludeFile "ImageFilter.pbi"

UsePNGImageDecoder()

;Image originale en couleur
Image = LoadImage(#PB_Any,"tomato.png")

;Image de sortie
ImageOut = CopyImage(Image, #PB_Any)

;AFfichage de l'image originale
OpenWindow(0, 100, 100, ImageWidth(Image), ImageHeight(Image), "Original", #PB_Window_SystemMenu)
ImageGadget(0, 0, 0, ImageWidth(Image), ImageHeight(Image), ImageID(Image))

;Cr�ation d'un pointeur sur le format RAW de l'image
StartDrawing(ImageOutput(Image))
  If ImageDepth(image) = 24
    *RawImage = CreateRawImage(ImageWidth(Image), ImageHeight(Image), DrawingBuffer(), #FORMAT_RGB)
  EndIf 
  
  If ImageDepth(image) = 32
    *RawImage = CreateRawImage(ImageWidth(Image), ImageHeight(Image), DrawingBuffer(), #FORMAT_RGBA)
  EndIf 
StopDrawing()

;Process : D�grad� de gris
GrayScaleRawImage(*RawImage)

;Copie du r�sultat du process dans l'image de sortie  
StartDrawing(ImageOutput(ImageOut))
  If ImageDepth(image) = 24
    CopyMemory(GetRawImagePixelsPtr(*RawImage), DrawingBuffer(), ImageWidth(Image) * ImageHeight(Image) * 3 )
  EndIf 
  
  If ImageDepth(image) = 32
    CopyMemory(GetRawImagePixelsPtr(*RawImage), DrawingBuffer(), ImageWidth(Image) * ImageHeight(Image) * 4 )
  EndIf   
StopDrawing()


;Affichage du r�sultat
OpenWindow(1, 0, 0, ImageWidth(Image), ImageHeight(Image), "GreyScale", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
ImageGadget(1, 0,0, ImageWidth(Image), ImageHeight(Image), ImageID(ImageOut))

;Sauvgarde de l'image obtenue
UsePNGImageEncoder()
SaveImage(Image, "test.png", #PB_ImagePlugin_PNG)

Repeat : Until WaitWindowEvent(10) = #PB_Event_CloseWindow
; IDE Options = PureBasic 5.42 LTS (Windows - x64)
; EnableUnicode
; EnableXP