
const { app, BrowserWindow } = require('electron')

let win = null

function createWin() {
  console.log(51725279);
  // 开启一个窗口
  win = new BrowserWindow({
    width: 1024,
    height: 768,
    webPreferences: {
      nodeIntegration: true,
    },
  })

  win.loadURL('http://localhost:5000/')
  // 加载html页面
  // win.loadFile(`file://${join(__dirname, '../render/index.html')}`)
}

app.whenReady().then(createWin)
