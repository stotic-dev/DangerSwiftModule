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
    LintTarget(directory: "../DangerSample", configPath: "../DangerSample/.swiftlint.yml")
]

for target in targets {
    
    let violations = SwiftLint.lint(.modifiedAndCreatedFiles(directory: target.directory),
                                    inline: true,
                                    configFile: target.configPath,
                                    quiet: false,
                                    swiftlintPath: lintPath)
    message("SwiftLintでの指摘数は\(violations.count)件です。")
}
