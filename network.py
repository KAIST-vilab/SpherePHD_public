import tensorflow as tf

initializer = tf.contrib.layers.xavier_initializer()
weights = {
    # 160*320
    'wc1': tf.Variable(initializer([10, 1, 1, 16])),
    # 80 *160
    'wc2': tf.Variable(initializer([10, 1, 16, 32])),
    # 40*80
    'wc3': tf.Variable(initializer([10, 1, 32, 10]))
}

biases = {
    'bc1': tf.Variable(initializer([16])),
    'bc2': tf.Variable(initializer([32])),
    'bc3': tf.Variable(initializer([10]))
}

def conv2d(x, W, b, callTable, strides=1):
    # Conv2D wrapper, with bias and relu activation
    x = tf.gather(x, callTable, axis=2)  # Turns x into an array of shape (B, inHeight, KernelSize,inWidth, inChannel)
    x = tf.squeeze(x, axis=1)  # squeeze the array into shape (B, KernelSize,inWidth, inChannel)
    x = tf.nn.conv2d(x, W, strides=[1, strides, strides, 1], padding='VALID')
    x = tf.nn.bias_add(x, b)
    # x = tf.layers.batch_normalization(x, training = True)
    return tf.nn.relu(x)

def maxpool(x, callTable, poolTable):
    x = tf.gather(x, callTable, axis=2)  # Turns x into an array of shape (B, inHeight, KernelSize,inWidth, inChannel)
    x = tf.squeeze(x, axis=1)  # squeeze the array into shape (B, KernelSize,inWidth, inChannel)
    x = tf.gather(x, poolTable, axis=2)  # Picks out correct pool indexes (B, KernelSize, inWidth/4, inChannel)
    x = tf.reduce_max(x, axis=1, keepdims=True)  # Max from pool (B, 1, inWidth/4, inChannel)
    return x

def avgpool(x):
    x = tf.reduce_mean(x, axis=[1, 2])
    return x


def conv_net(x, weights, biases, callTable, poolTable, div):
    conv1 = conv2d(x, weights['wc1'], biases['bc1'], callTable[1][div].T)
    conv1 = maxpool(conv1, callTable[0][div].T, poolTable[div - 1].T)

    conv2 = conv2d(conv1, weights['wc2'], biases['bc2'], callTable[1][div - 1].T)
    conv2 = maxpool(conv2, callTable[0][div - 1].T, poolTable[div - 2].T)

    conv3 = conv2d(conv2, weights['wc3'], biases['bc3'], callTable[1][div - 2].T)
    out = avgpool(conv3)
    return out


