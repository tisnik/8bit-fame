package main_test

import (
	"bytes"
	"io"
	"os"
	"testing"
	"time"

	"github.com/stretchr/testify/assert"
	main "goto_basic"
)

func readSource(t *testing.T, path string) string {
	file, err := os.Open(path)
	assert.NoError(t, err, "open file with expected generated BASIC source")

	defer file.Close()
	data, err := io.ReadAll(file)
	assert.NoError(t, err, "read file with expected generated BASIC source")

	return string(data)
}

func TestGenerateBasicSource(t *testing.T) {
	var buffer bytes.Buffer

	timestamp := time.Date(2000, 1, 10, 10, 20, 00, 00, time.UTC)

	main.GenerateBasicSource(&buffer, timestamp)

	expectedOutput := readSource(t, "testdata/empty.bas")
	assert.Equal(t, expectedOutput, buffer.String())
}
