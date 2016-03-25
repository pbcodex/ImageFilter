;http://lodev.org/cgtutor/filtering.html#Find_Edges_

XIncludeFile "ImageFilter.pbi"

UsePNGImageDecoder()

factor.d = 1 
bias.d = 0
filterWidth = 5
filterHeight = 5

*Emboss  = CreateFilter(filterWidth, filterHeight, factor, bias, ?filter_FindEdges)

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
OpenWindow(1, 0, 0, ImageWidth(Image), ImageHeight(Image), "Find Edges", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
ImageGadget(1, 0,0, ImageWidth(Image), ImageHeight(Image), ImageID(Image))

Repeat : Until WaitWindowEvent(10) = #PB_Event_CloseWindow

DataSection  
  filter_FindEdges:
  
  Data.d -0,  0, -1,  0,  0
  Data.d  0,  0, -1,  0,  0
  Data.d  0,  0,  2,  0,  0
  Data.d  0,  0,  0,  0,  0
  Data.d  0,  0,  0,  0,  0
  
EndDataSection

; IDE Options = PureBasic 5.42 LTS (Windows - x86)
; CursorPosition = 35
; EnableUnicode
; EnableXP