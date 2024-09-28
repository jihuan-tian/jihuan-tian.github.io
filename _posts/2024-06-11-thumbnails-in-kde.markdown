---
layout: post
title: Thumbnails in KDE
date: 2024-06-11
categories: [computer]
tags: [KDE,Dolphin,Gwenview]
mathjax: false
---

Install the following Debian packages and enable them in the &ldquo;Preview&rdquo; tab within Dolphin&rsquo;s &ldquo;General&rdquo; configuration page.

-   `kdegraphics-thumbnailers`: for advanced graphic file formats, such as PS, RAW.
-   `kdegraphics-mobipocket`: for mobi books.
-   `djvulibre-bin`: for DjVu books.
-   `ffmpegthumbs`: video thumbnail generator for KDE file managers like Dolphin and Konqueror. N.B. Do not mix this up with `ffmpegthumbnailer`, which is a command line tool for generating thumbnails and not supported by Dolphin.

![img](/figures/2022-12-19_15-00-00-dolphin-preview-plugins.png "Preview preferences in Dolphin")

For the preview of DjVu files in Dolphin, it was strange at the beginning that DjVu files couldn&rsquo;t be previewed in Dolphin. Then I tried to debug this problem by starting Dolphin from command line as below, which enabled a printout of the error message.

```text
QT_LOGGING_RULES="org.kde.dolphin=true" dolphin
```

The error message read

```text
kf.coreaddons: Expected a KPluginFactory, got a KIOPluginForMetaData
kf.kio.workers.thumbnail.djvu: QProcess::FailedToStart ""
```

Obviously, the thumbnail process couldn&rsquo;t be started by Dolphin and the keyword `kf.kio.workers.thumbnail.djvu` seemed a clue. So I searched it on Google and found this source code from [here](https://github.com/KDE/kio-extras/blob/master/thumbnail/djvucreator.cpp):

```C++
KIO::ThumbnailResult DjVuCreator::create(const KIO::ThumbnailRequest &request)
{
  QProcess ddjvu;

  const QStringList args{QStringLiteral("-page=1"),
                         QStringLiteral("-size=") + QString::number(request.targetSize().width()) + QChar('x')
                         + QString::number(request.targetSize().height()),
                         QStringLiteral("-format=ppm"),
                         request.url().toLocalFile()};

  ddjvu.start(QStringLiteral("ddjvu"), args);
  ddjvu.waitForFinished();

  static bool warnOnce = true;
  if (ddjvu.exitCode() != 0) {
    if (warnOnce) {
      qCWarning(KIO_THUMBNAIL_DJVU_LOG) << ddjvu.error() << ddjvu.readAllStandardError();
      warnOnce = false;
    }
    return KIO::ThumbnailResult::fail();
  }

  QImage img;
  bool okay = img.load(&ddjvu, "ppm");
  return okay ? KIO::ThumbnailResult::pass(img) : KIO::ThumbnailResult::fail();
}
```

It can be seen that the command `ddjvu` is to be called. However, it was not available on my Debian system (it is strange that why `ddjvu` has not been included as one of the dependencies of the `dolphin` package). Actually, `ddjvu` is contained in the Debian package `djvulibre-bin`, which should be manually installed. This just solves the problem.

After enabling our interested preview plugins, we can see the video thumbnails in both Dolphin and Gwenview.

![img](/figures/2022-12-19_15-12-21-video-thumbnails-in-dolphin.png "Preview of videos in Dolphin")

![img](/figures/2022-12-19_15-12-59-video-thumbnails-in-gwenview.png "Preview of videos in Gwenview")

This is the preview of PDF and DjVu files in Dolphin.

![img](/figures/2024-06-11_10-07-18-djvu-preview-in-dolphin.png "Preview of DjVu files in Dolphin")

{{ 2024-06-11-thumbnails-in-kde | backlink }}
