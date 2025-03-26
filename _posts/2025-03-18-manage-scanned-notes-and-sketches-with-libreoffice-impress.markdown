---
layout: post
title: Manage scanned notes and sketches with LibreOffice Impress
date: 2025-03-19
categories: [computer]
tags: [LibreOffice,Bash,note-taking]
mathjax: false
---

Just realized I can use LibreOffice Impress to collect my scattered scanned images for mathematical derivations on paper work journal and notebook as well as white board. Compared to LibreOffice Draw, the pages in Impress can be easily shifted and reorganized.

-   A VBA script has been written for inserting, positioning and resizing the images automatically in LibreOffice Impress.
    
    ```vba
    ' Multiple images can be selected and inserted into Impress in batch, one image
    ' per page.
    Sub InsertImagesFromSelectedFolder()
        ' Get the current document (LibreOffice Draw)
        Dim oDoc As Object
        oDoc = ThisComponent
    
        ' Open the folder and check if it's a directory
        Dim files as Object
        files = SelectMultipleImages()
    
        ' Loop through each file in the folder
        Dim i As Integer
        For i = LBound(files) To UBound(files)
            Dim sFile as String
            sFile = files(i)
            ' Check if the file is an image (you can modify this to include more formats)
            If (InStr(LCase(sFile), ".png") > 0 Or InStr(LCase(sFile), ".jpg") > 0 Or InStr(LCase(sFile), ".jpeg") > 0) Then
                ' Create a new page for each image by inserting into DrawPages
                Dim oPages As Object
                oPages = oDoc.getDrawPages()
                Dim oPage As Object
                oPage = oPages.insertNewByIndex(oPages.getCount())
                oPage.setName(ConvertFromURL(sFile))
    
                ' Create the image shape
                Dim oGraph As Object
                oGraph = oDoc.createInstance("com.sun.star.drawing.GraphicObjectShape")
                oGraph.GraphicURL = sFile
    
                ' Get the image size by callign a Bash script, because they cannot
                ' be acquired from LibreOffice VBA directly.
                CallBashScript("/usr/local/bin/scripts/call_get_img_size.sh", ConvertFromURL(sFile))
                Dim oInputFile as Object
                oInputFile = CreateUnoService("com.sun.star.ucb.SimpleFileAccess")
                Dim oInputStream as Object
                oInputStream = oInputFile.openFileRead("/tmp/libreoffice/img-size.txt")
                Dim sFileContent as String
                sFileContent = ReadInputStream(oInputStream)
                oInputStream.closeInput()
                Dim aSizeParts() as String
                aSizeParts = Split(sFileContent, "x")
    
    	    ' Sclae the image with respect to the page size. N.B. The size unit
    	    ' adopted by LibreOffice is 1/100 mm.
                Dim dpi As Integer
                dpi = 168
                Dim oBitmapSize As New com.sun.star.awt.Size
                oBitmapSize.Width = Val(Trim(aSizeParts(0))) / dpi * 25.4 * 100
                oBitmapSize.Height = Val(Trim(aSizeParts(1))) / dpi * 25.4 * 100
    
                Dim oNewSize As New com.sun.star.awt.Size    'New Image size     
                Dim dImageRatio As Double     'Ratio of the height to width
                Dim dPageRatio As Double      'Ratio of the height to width
    
                dImageRatio = CDbl(oBitmapSize.Height) / CDbl(oBitmapSize.Width)
                dPageRatio = CDbl(oPage.Height) / CDbl(oPage.Width)
    
                ' Compare the ratios to see which is wider, relatively speaking
                If oBitmapSize.Width > oPage.Width OR oBitmapSize.Height > oPage.Height Then
    		If dPageRatio > dImageRatio Then
                        oNewSize.Width  = oPage.Width
                        oNewSize.Height = CLng(CDbl(oPage.Width) * dImageRatio)
    		Else
                        oNewSize.Width  = CLng(CDbl(oPage.Height) / dImageRatio)
                        oNewSize.Height = oPage.Height
    		End If
                Else
    		oNewSize = oBitmapSize
                End If
    
                ' Add the image to the current page.
                oGraph.SetSize(oNewSize)
    
                ' Center the image on the page.
                Dim oPosition as new com.sun.star.awt.Point
                oPosition.X = (oPage.Width - oNewSize.Width)/2
                oPosition.Y = (oPage.Height - oNewSize.Height)/2
                oGraph.SetPosition(oPosition)
    
                oPage.add(oGraph)
            End If
        Next i
    End Sub
    
    ' Function to display the file picker dialog and return the selected folder
    Function SelectMultipleImages() As Object
        Dim oFilePicker As Object
        Dim folderPath As String
    
        ' Create the file picker service
        oFilePicker = CreateUnoService("com.sun.star.ui.dialogs.FilePicker")
    
        ' Set dialog properties
        oFilePicker.setMultiSelectionMode (True)
        oFilePicker.setTitle("Select Folder with Images")
        oFilePicker.execute()
    
        SelectMultipleImages = oFilePicker.getSelectedFiles()
    End Function
    
    ' Call a Bash script. LibreOffice VBA can only start a asynchronous process, so
    ' we need to wait for 1000 ms to let the script finish. Also note the argument
    ' list in the string passed to the Bash script does not need to be escaped.
    Sub CallBashScript(sScriptPath As String, sArgs As String)
        Dim oShell As Object
    
        ' Create a Shell object and execute the command
        oShell = CreateUnoService("com.sun.star.system.SystemShellExecute")
        oShell.execute(sScriptPath, sArgs, 0)  ' The second parameter "0" is to run in the background
        Wait 1000
    End Sub
    
    ' Read the content as a string from an input stream.
    Function ReadInputStream(oInputStream As Object) As String
        Dim sContent As String
        Dim oTextStream As Object
        Dim aBytes() As Byte
        Dim nBytes As Integer
    
        ' Read data from input stream
        oTextStream = CreateUnoService("com.sun.star.io.TextInputStream")
        oTextStream.setInputStream(oInputStream)
        oTextStream.setEncoding("UTF-8") ' Adjust encoding if necessary
    
        ' Read the full content
        sContent = oTextStream.readLine()
    
        ' Return content as a string
        ReadInputStream = sContent
    End Function
    ```
    
    The Bash script `call_get_img_size.sh` is as below. It calls `identify` to get the image information, from which we write the image size into a temporary file.
    
    ```bash
    echo $(identify "$1" | gawk '{if(match($0, /([[:digit:]]+)x([[:digit:]]+)/, res) != 0) print res[0];}') > /tmp/libreoffice/img-size.txt
    ```

-   For eye-protection, the white background of each image is converted to light yellow, i.e. RGB 246, 240, 222, with the command line image editing tool ImageMagick.
    
    ```bash
    #!/bin/bash
    mogrify -fuzz 10% -fill 'rgb(246,240,222)' -opaque white "$file"
    ```
-   The handwriting in each inserted image can be further edited with Wacom+Krita.
-   The whole Impress document or its internal bookmarks can be further linked into Org mode, so that they can be categorized and tagged in the [Zettelkasten]({% post_url 2024-10-01-基于卡片笔记写作法的个人笔记改进 %}) note system.

{{ "2025-03-18-manage-scanned-notes-and-sketches-with-libreoffice-impress" | backlink }}
