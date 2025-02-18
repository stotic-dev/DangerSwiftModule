import Danger

let danger = Danger()

// PRのタイトルが "WIP" を含んでいる場合、警告を出す
if danger.github.pullRequest.title.contains("WIP") {
    warn("PRが 'WIP' のままです。完了したらタイトルを変更してください。")
}

// PRの説明が短すぎる場合に警告を出す
if let body = danger.github.pullRequest.body, body.count < 100 {
    warn("PRの説明が短すぎます。詳細を追加してください。")
}

// 変更行が500行を超える場合に警告を出す
let changeFilesCount = danger.github.pullRequest.additions ?? 0
if changeFilesCount > 500 {
    warn("変更行数が500行を超えています(修正行: \(changeFilesCount))。PRを小さく分けられるか検討してください。")
}

// SwiftLintの設定

struct LintTarget {
    let directory: String
    let configPath: String
}

let swiftLintCmdPath = ".build/artifacts/swiftlintplugins/SwiftLintBinary/SwiftLintBinary.artifactbundle/swiftlint-0.58.2-macos/bin/swiftlint"
let lintPath = SwiftLint.SwiftlintPath.bin(swiftLintCmdPath)
let targets: [LintTarget] = [
    LintTarget(directory: "DangerSample", configPath: "../DangerSample/.swiftlint.yml")
]

let changeFiles = (danger.git.createdFiles + danger.git.modifiedFiles).filter { $0.fileType == .swift }
for target in targets {
    
    let targetFiles = changeFiles.filter { $0.hasPrefix(target.directory) }
//    let violations = SwiftLint.lint(.files(targetFiles),
//                                    inline: true,
//                                    configFile: target.configPath,
//                                    quiet: false,
//                                    swiftlintPath: lintPath)
    let violations = SwiftLint.lint(.all(directory: "../DangerSample"),
                                    inline: true,
                                    configFile: target.configPath,
                                    quiet: false,
                                    swiftlintPath: lintPath)
    message("SwiftLintでの対象ファイル数は\(targetFiles.count), 指摘数は\(violations.count)件です。")
//    targetFiles.forEach {
//        message("SwiftLint対象ファイル: " + $0.name)
//    }
}
