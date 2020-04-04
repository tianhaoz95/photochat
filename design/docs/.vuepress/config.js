module.exports = {
  base: "/design-docs/",
  plugins: ["@vuepress/medium-zoom"],
  locales: {
    "/": {
      lang: "en-US",
      title: "Mini Donkey Design Docs",
      description: "Home for all Mini Donkey design docs",
    },
    "/zh/": {
      lang: "zh-CN",
      title: "小驴za设计文档",
      description: "小驴za设计文档汇总",
    },
  },
  themeConfig: {
    logo: "/donkey_logo_512_rounded.png",
    repo: "tianhaoz95/photochat",
    editLinks: true,
    sidebar: "auto",
    locales: {
      "/": {
        selectText: "Languages",
        label: "English",
        editLinkText: "Edit this page on GitHub",
        lastUpdated: "Last Updated",
      },
      "/zh/": {
        selectText: "选择语言",
        label: "简体中文",
        editLinkText: "在GitHub上编辑此页面",
        lastUpdated: "最后更新",
      },
    },
  },
};
