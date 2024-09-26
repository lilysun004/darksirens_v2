lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 3.460660660660661 --fixed-mass2 47.66782782782783 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010398943.6617932 \
--gps-end-time 1010406143.6617932 \
--d-distr volume \
--min-distance 727.9631743790166e3 --max-distance 727.9831743790165e3 \
--l-distr fixed --longitude 117.73348236083984 --latitude 24.044795989990234 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
