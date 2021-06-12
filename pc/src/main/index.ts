import { join } from 'path'
import { app, BrowserWindow } from 'electron'




let win = null

function createWin() {
  // 开启一个窗口
  win = new BrowserWindow({
    width: 1024,
    height: 768,
    webPreferences: {
      nodeIntegration: true,
    },
  })

  // 加载html页面
  win.loadFile(`file://${join(__dirname, '../render/index.html')}`)
}

app.whenReady().then(createWin)
