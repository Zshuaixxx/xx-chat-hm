import { promptAction } from '@kit.ArkUI';

/**
 * 消息类型
 */
@ObservedV2
class messageType {
  role: string
  @Trace context: string

  constructor() {
    this.role = 'user'
    this.context = ''
  }
}


@Entry
@Component
export struct MainPage {
  @State scrollHeight: number = 0
  bgc: string = '#C8EE9D'
  TextAreaController: TextAreaController = new TextAreaController()
  listScroller: Scroller = new Scroller()
  /**
   * 消息列表:messageType[]
   */
  @State messages: messageType[] = [
    { role: 'user', context: '你好' },
    { role: 'assistant', context: '你好，我是arkui，你可以向我提问任何问题' },
    { role: 'user', context: '你叫什么名字' },
    { role: 'assistant', context: '我的名字叫arkui' },
    {
      role: 'user',
      context: '你今年多大你今年多大你今年多大你今年多大你今年多大你今年多大你今年多大你今年多大你今年多大你今年多大你今年多大你今年多大你今年多大你今年多大你今年多大'
    },
    { role: 'assistant', context: '我今年18岁' },
    { role: 'user', context: '你喜欢什么' },
    { role: 'assistant', context: '我喜欢吃大餐' },
    { role: 'user', context: '你喜欢吃什么' },
    {
      role: 'assistant',
      context: '你好，我是arkui，你可以向我提问任何问题好，我是arkui，你可以向我提问任何问题好，我是arkui，你可以向我提问任何问题好，我是arkui，你可以向我提问任何问题好，我是arkui，你可以向我提问任何问题'
    },
    { role: 'user', context: '你叫什么名字' },
    { role: 'assistant', context: '我的名字叫arkui' },
    { role: 'user', context: '你今年多大' },
    { role: 'assistant', context: '我今年18岁' },
    { role: 'user', context: '你喜欢什么' },
    { role: 'assistant', context: '我喜欢吃大餐' },
  ]
  /**
   * 输入框内容:string
   */
  @State inputValue: string = ''
  /**
   * 模拟的回复数据
   */
  allReplyMessages: string[] = [
    '你好，我是arkui，你可以向我提问任何问题',
    '你好！我是一个由人工智能驱动的助手，可以帮助回答问题、提供信息和建议。如果你有任何问题或者需要帮助，请随时告诉我！',
    '从前，在一个宁静的小村庄里，有一位名叫艾米莉的年轻女孩。艾米莉十分喜爱大自然，她常常在森林里漫步，沉' +
      '浸在鸟语花香之中。' +
      '一天傍晚，艾米莉像往常一样在森林中散步，突然听到一阵微弱的哭声。循着声音，她发现草丛里竟然有一只受伤' +
      '的小狐狸。小狐狸显得很虚弱，似乎无法继续旅行。\n' +
      '艾米莉心生怜悯，她小心翼翼地把小狐狸抱回了家。经过几天的精心照料，小狐狸终于康复了。它的毛色逐渐恢复' +
      '光泽，眼睛里也重新闪烁着活力。\n' +
      '康复后的小狐狸对艾米莉充满了感激之情。每天清晨，它都会在艾米莉的窗前等候，仿佛在说：“谢谢你，艾米' +
      '莉。＂它们成了形影不离的好朋友。\n' +
      '有一天，村庄遭遇了罕见的暴风雨，滚滚的洪水向村庄袭来。就在大家都慌忙撤离时，小狐狸用它灵敏的感知力带' +
      '领艾米莉和村民们找到了一条安全的撤退路线。最终，全村人都安然无恙地避开了这场灾难。\n' +
      '村庄的人们都感慨于艾米莉的善良和小狐狸的机智。从此，这对特别的朋友在村庄里广为传颂，成为了帮助彼此、' +
      '互助互爱的美好象征。\n' +
      '这是一个关于善良与友谊的小故事，提醒我们有时候给予一点温暖，也许就能收获意想不到的回报。',
    '鸿蒙是由华为开发的一种新型分布式操作系统，旨在提供跨设备的无缝连接和统一体验。鸿蒙操作系统（HarmonyOS）最初于2019年发布，华为将其定位为适用于各种智能设备的系统，从智能手机、平板电脑到家电、可穿戴设备和物联网设备等。',
    '鸿蒙生态的快速发展离不开鸿蒙原生应用、元服务的开发，为了有效提升生态开发者开发效率，降低开发成本，华为AppGallery Connect推出了丰富的创新能力、华为开发者联盟生态市场也已上线「鸿蒙生态伙伴模板＆组件专区」。\n' +
      '\n' +
      '本次活动旨在推动开发者开发优质模板/组件，诚邀各位开发者产出优质模板/组件获取相应奖励，优秀开发模板/组件作品还将上线至生态市场「鸿蒙生态伙伴模板＆组件专区」。'
  ]

  /**
   * 页面展示
   */
  onPageShow() {
    this.changeScrollHeight()
  }

  /**
   * 改变输入框的Scroll容器的高度
   */
  changeScrollHeight() {
    console.log('zxxcxf--', this.TextAreaController.getTextContentLineCount())
    let line = this.TextAreaController.getTextContentLineCount()
    if (line === 0 || line == 1) {
      this.scrollHeight = 50
      return
    }
    if (line > 4) {
      this.scrollHeight = 100
    } else {
      this.scrollHeight = 20 * line + 20
    }
  }

  /**
   * 发送消息
   */
  sendMessage() {
    if (this.inputValue.trim() === '') {
      promptAction.showToast({
        message: '请输入内容',
        duration: 1500
      })
      return
    }
    this.messages.push({ role: 'user', context: this.inputValue })
    this.inputValue = ''
    this.changeScrollHeight()
    this.listScroller.scrollEdge(Edge.Bottom)
    this.replyMessage()
  }

  /**
   * 回复消息
   */
  replyMessage() {
    this.messages.push({ role: 'assistant', context: '' })
    let index = 0;
    let reply = this.allReplyMessages[Math.floor(Math.random() * this.allReplyMessages.length)]
    this.typer(index, reply)
  }

  /**
   * 打字机
   * @param index
   * @param reply
   */
  typer(index: number, reply: string) {
    if (index > reply.length) {
      return
    }
    setTimeout(() => {
      // this.messages[this.messages.length - 1].context = reply.substring(0, index)
      this.messages[this.messages.length - 1] = {
        role: 'assistant',
        context: reply.substring(0, index)
      }
      index++;
      this.typer(index, reply)
      this.listScroller.scrollEdge(Edge.Bottom)
      console.log('zxxcxf--' + this.messages[this.messages.length - 1].context)
    }, 100)
  }

  build() {
    Column() {
      //聊天区域
      Column() {
        List({
          space: 10,
          initialIndex: this.messages.length - 1,
          scroller: this.listScroller
        }) {
          ForEach(this.messages, (message: messageType, index: number) => {
            ListItem() {
              Row() {
                Image(message.role === 'user' ? $r('app.media.me') : $r('app.media.chat'))
                  .width(40)
                  .aspectRatio(1)
                Row() {
                  Text(message.context)
                    .backgroundColor(message.role === 'user' ? '#9489CD' : '#FDF8FF')
                    .fontSize(20)
                    .fontColor('#1C1B21')
                    .padding(10)
                    .textAlign(TextAlign.Start)
                    .borderRadius(10)
                }
                .justifyContent(message.role === 'user' ? FlexAlign.End : FlexAlign.Start)
                .layoutWeight(1)
              }
              .alignItems(VerticalAlign.Top)
              .width('100%')
              .reverse(message.role === 'user')
            }
          })
        }
        .padding({
          top: 10,
          bottom: 10,
          left: 10,
          right: 10
        })
      }
      .backgroundColor(this.bgc)
      .layoutWeight(1)
      .width('100%')

      // 输入框
      Row() {
        TextArea({
          placeholder: '请输入内容',
          text: $$this.inputValue,
          controller: this.TextAreaController
        })
          .height('100%')
          .margin(0)
          .layoutWeight(1)
          .fontSize(20)
          .lineHeight(30)
          .enterKeyType(EnterKeyType.Send)
          .backgroundColor(Color.White)
          .onChange((value: string) => {
            this.changeScrollHeight()
          })
          .onSubmit(() => {
            this.sendMessage()
          })
        Image($r('app.media.top'))
          .width(50)
          .aspectRatio(1)
          .fillColor(this.inputValue === '' ? Color.Gray : Color.Black)
          .onClick(() => {
            this.sendMessage()
          })
      }
      .width('100%')
      .height(this.scrollHeight)
      .alignItems(VerticalAlign.Bottom)
      .backgroundColor(Color.White)
      .borderRadius({
        topLeft: 20,
        topRight: 20
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.bgc)
  }
}
