module.exports = {
  base: '/design-docs/',
  locales: {
    '/': {
      lang: 'en-US',
      title: 'Mini Donkey Design Docs',
      description: 'Home for all Mini Donkey design docs'
    },
    '/zh/': {
      lang: 'zh-CN',
      title: '小驴za设计文档',
      description: '小驴za设计文档汇总'
    }
  },
  themeConfig: {
    logo: 'donkey_logo_512_rounded.png',
    locales: {
      '/': {
        selectText: 'Languages',
        label: 'English'
      },
      '/zh/': {
        selectText: '选择语言',
        label: '简体中文'
      }
    }
  }
}
