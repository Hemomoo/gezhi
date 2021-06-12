
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

  console.log(252592);

  win.loadURL('http://localhost:3000/')
  // 加载html页面
  // win.loadFile(`file://${join(__dirname, '../render/index.html')}`)
}

app.whenReady().then(createWin)
