//
//  MMSpanTests.m
//  MMMarkdown
//
//  Copyright (c) 2012 Matt Diephouse.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "MMTestCase.h"


@interface MMSpanTests : MMTestCase

@end

@implementation MMSpanTests

//==================================================================================================
#pragma mark -
#pragma mark Code Span Tests
//==================================================================================================

- (void)testCodeSpans
{
    NSString *markdown = @"`*Test* \\\\ code`\n";
    NSString *html = @"<p><code>*Test* \\\\ code</code></p>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testCodeSpans_withSpaces
{
    NSString *markdown = @"a ` b ` c";
    NSString *html = @"<p>a <code>b</code> c</p>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testCodeSpans_doubleBackticks
{
    NSString *markdown = @"`` `foo` ``\n";
    NSString *html = @"<p><code>`foo`</code></p>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testCodeSpans_multipleBackticks
{
    NSString *markdown = @"``` `foo` ```\n";
    NSString *html = @"<p><code>`foo`</code></p>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testCodeSpans_withAmpersand
{
    MMAssertMarkdownEqualsHTML(@"`a&b`", @"<p><code>a&amp;b</code></p>");
}

- (void)testCodeSpans_withAngleBrackets
{
    MMAssertMarkdownEqualsHTML(@"`<html>`", @"<p><code>&lt;html&gt;</code></p>");
}

- (void)testCodeSpans_thatGoesToEndOfString
{
    MMAssertMarkdownEqualsHTML(@"```\nblah", @"<p>```\nblah</p>");
}

- (void)testCodeSpans_withNewlines
{
    MMAssertMarkdownEqualsHTML(@"`\n1\n2\n`", @"<p><code>\n1\n2\n</code></p>");
}


//==================================================================================================
#pragma mark -
#pragma mark Em and Strong Tests
//==================================================================================================

- (void)testEm
{
    MMAssertMarkdownEqualsHTML(@"*foo*", @"<p><em>foo</em></p>");
    MMAssertMarkdownEqualsHTML(@"_foo_", @"<p><em>foo</em></p>");
}

- (void)testEmAcrossNewline
{
    MMAssertMarkdownEqualsHTML(@"*Foo\nbar*", @"<p><em>Foo\nbar</em></p>");
    MMAssertMarkdownEqualsHTML(@"_Foo\nbar_", @"<p><em>Foo\nbar</em></p>");
}

- (void)testEmInTheMiddleOfAWord
{
    MMAssertMarkdownEqualsHTML(@"un*frigging*believable", @"<p>un<em>frigging</em>believable</p>");
    MMAssertMarkdownEqualsHTML(@"un_frigging_believable", @"<p>un<em>frigging</em>believable</p>");
}

- (void)testStrong
{
    MMAssertMarkdownEqualsHTML(@"**foo**", @"<p><strong>foo</strong></p>");
    MMAssertMarkdownEqualsHTML(@"__foo__", @"<p><strong>foo</strong></p>");
}

- (void)testStrongAcrossNewline
{
    MMAssertMarkdownEqualsHTML(@"**Foo\nbar**", @"<p><strong>Foo\nbar</strong></p>");
    MMAssertMarkdownEqualsHTML(@"__Foo\nbar__", @"<p><strong>Foo\nbar</strong></p>");
}

- (void)testStrongInTheMiddleOfAWord
{
    MMAssertMarkdownEqualsHTML(@"un**frigging**believable", @"<p>un<strong>frigging</strong>believable</p>");
    MMAssertMarkdownEqualsHTML(@"un__frigging__believable", @"<p>un<strong>frigging</strong>believable</p>");
}

- (void)testStrongEm
{
    MMAssertMarkdownEqualsHTML(@"***foo***", @"<p><strong><em>foo</em></strong></p>");
    MMAssertMarkdownEqualsHTML(@"___foo___", @"<p><strong><em>foo</em></strong></p>");
    MMAssertMarkdownEqualsHTML(@"__*foo*__", @"<p><strong><em>foo</em></strong></p>");
    MMAssertMarkdownEqualsHTML(@"**_foo_**", @"<p><strong><em>foo</em></strong></p>");
}

- (void)testStrongEmInTheMiddleOfAWord
{
    MMAssertMarkdownEqualsHTML(@"un***frigging***believable", @"<p>un<strong><em>frigging</em></strong>believable</p>");
    MMAssertMarkdownEqualsHTML(@"un___frigging___believable", @"<p>un<strong><em>frigging</em></strong>believable</p>");
    MMAssertMarkdownEqualsHTML(@"un__*frigging*__believable", @"<p>un<strong><em>frigging</em></strong>believable</p>");
    MMAssertMarkdownEqualsHTML(@"un**_frigging_**believable", @"<p>un<strong><em>frigging</em></strong>believable</p>");
}

- (void)testStrongInsideEm
{
    MMAssertMarkdownEqualsHTML(@"***test** test*", @"<p><em><strong>test</strong> test</em></p>");
}


//==================================================================================================
#pragma mark -
#pragma mark Line Break Tests
//==================================================================================================

- (void)testBasicLineBreak
{
    MMAssertMarkdownEqualsHTML(@"A line  \nwith a break  ", @"<p>A line <br />\nwith a break  </p>");
}

- (void)testBasicLineBreak_carriageReturn
{
    MMAssertMarkdownEqualsHTML(@"A line  \rwith a break  ", @"<p>A line <br />\nwith a break  </p>");
}

- (void)testBasicLineBreak_carriageReturnLineFeed
{
    MMAssertMarkdownEqualsHTML(@"A line  \r\nwith a break  ", @"<p>A line <br />\nwith a break  </p>");
}


@end
